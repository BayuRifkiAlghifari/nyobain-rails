class BookController < ApplicationController
	
	def index
		@title = 'Book'
		@ggwp = Book.ransack(params[:q]).result.to_sql
	end

	def find
		render json: Book.find(params[:id])
	end

	def ajax_data
		render json: BookDatatable.new(params)
	end

	def create
		exe = store(Book, book_params, true)
		
		if exe
			render json: exe, status: :created
		else
			render json: exe.errors, status: :unproccessable_entity
		end
	end

	def update
		exe = edit(Book, book_params, params[:id], true)

		if exe
			render json: exe, status: :ok
		else
			render json: exe.errors, status: :unproccessable_entity
		end
	end

	def delete
		exe = destroy(Book, params[:id], true)

		if exe
			render json: exe, status: :ok
		else
			render json: exe.errors, status: :unproccessable_entity
		end
	end

	def send_mail
		render json: BookMailer.ok.deliver_now
	end

	def test_side_kiq
		# BookWorker.perform_async("07-01-2021", "08-01-2021")
		BookWorker.perform_in(1.minutes, 'bob', 5)
	end

	def test_ransack
	end

	private
	def book_params
		params.require(:data).permit(:title, :desc, :price, :author, :image)
	end
end
