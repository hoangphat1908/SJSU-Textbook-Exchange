class User < ApplicationRecord
	before_save {self.email = email.downcase}
	before_create :confirmation_token

	has_many :posts, dependent: :destroy
	before_save {self.email = email.downcase}
	
	validates :first, :last, presence: true,
					 length: {maximum: 50}

	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
					length: { maximum: 100},
					format: { with: VALID_EMAIL},
					uniqueness: { case_sensitive: false}
	
	has_secure_password
	validates :password, presence: true,
					 length: {minimum: 6}
	attr_accessor :remember_token


	#Reference: Private messaging tutorial http://josephndungu.com/tutorials/private-inbox-system-in-rails-with-mailboxer
	#added for mailboxer
	acts_as_messageable
	def mailboxer_name
		self.first
	end

	def mailboxer_email(object)
		self.email
	end

	#Reference: Email Confirmation Tutorial https://coderwall.com/p/u56rra/ruby-on-rails-user-signup-email-confirmation-tutorial
	#added for email activation
	def email_activate
 		self.email_confirmed = true
 		self.confirm_token = nil
 		save!(:validate =>false)
 	end

	private
	def confirmation_token
		if self.confirm_token.blank?
			self.confirm_token = SecureRandom.urlsafe_base64.to_s
		end	
	end
	
end
