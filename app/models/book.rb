class Book < ApplicationRecord
	validates :title, presence: true
	validates :picture, presence: true
  validates :post_id, presence: true
  belongs_to :post
  mount_uploader :picture, PictureUploader
  def self.search(search)
  	if search
  		where (["title LIKE ?","%#{search}%"])
  	else
  		all
  	end
  end
end
