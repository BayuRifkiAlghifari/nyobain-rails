class BookController < ApplicationController
	before_action :authenticate_user!

	def index
	end

	def ajax_data
		respond_to do |format|
			format.json { render json: BookDatatable.new(params) }
		end
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
