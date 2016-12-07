class Post < ApplicationRecord
	belongs_to :user
	
	validates :body, presence: true
	validates :user_id, presence: true

	has_many :books
	has_many :comments, dependent: :destroy
end