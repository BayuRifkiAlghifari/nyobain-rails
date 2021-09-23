module ApplicationHelper

	# Create data
	def store(model, data, authorize = false)
		exe = model.new(data)

		if authorize
			authorize exe, :create?
		end

		exe.image_derivatives! if exe.respond_to?(:image)

		exe.save!

		exe
	end

	# Update data
	def edit(model, data, id, authorize = false)
		exe = model.find(id)

		if authorize
			authorize exe, :update?
		end

		exe.update!(data)

		exe.image_derivatives! if exe.respond_to?(:image)
	end

	# Delete data
	def destroy(model, id, authorize = false)
		exe = model.find(id)

		if authorize
			authorize exe, :delete?
		end

		exe.destroy!
	end
end
