class BookController < ApplicationController
	before_action :authenticate_user!

	def index
		@title = 'Book'
	end

	def find
		render json: Book.find(params[:id])
	end

	def ajax_data
		render json: BookDatatable.new(params)
	end

	def create
		exe = Book.new(book_params)

		if exe.save
			render json: exe, status: :created
		else
			render json: exe.errors, status: :unproccessable_entity
		end
	end

	def update
		exe = Book.find(params[:id])

		if exe.update(book_params)
			render json: exe, status: :ok
		else
			render json: exe.errors, status: :unproccessable_entity
		end
	end

	def delete
		exe = Book.find(params[:id])

		if exe.destroy
			render json: exe, status: :ok
		else
			render json: exe.errors, status: :unproccessable_entity
		end
	end

	def book_params
		params.require(:data).permit(:title, :desc, :price, :author)
	end
end
