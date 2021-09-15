class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	include Pundit

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	private
		def user_not_authorized
			if request.content_type == 'application/x-www-form-urlencoded'
				render json: [], status: :unauthorized
			else
			end
		end
end
