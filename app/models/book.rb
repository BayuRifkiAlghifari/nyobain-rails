class Book < ApplicationRecord
	include ImageUploader::Attachment(:image)

	validates :title, presence: true
	validates :price, presence: true, numericality: true
	validates :desc, presence: true
	validates :author, presence: true
	validates :image, presence: true
end
