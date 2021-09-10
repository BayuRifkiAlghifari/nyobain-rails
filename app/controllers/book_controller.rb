class BookController < ApplicationController
	before_action :authenticate_user!

	def index
		@book = Book.all
	end

	def create
		book = Book.new(book_params)

		if book.save
			render json: book, status: :created
		else
			render json: book.errors, status: :unproccessable_entity
		end
	end

	def book_params
		params.require(:book).permit(:title, :desc, :price, :author)
	end
end
