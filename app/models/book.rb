class Book < ApplicationRecord
	validates :title, presence: true
	validates :price, presence: true, numericality: true
	validates :desc, presence: true
	validates :author, presence: true
end
