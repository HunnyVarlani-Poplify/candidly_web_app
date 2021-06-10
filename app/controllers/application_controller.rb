class ApplicationController < ActionController::API

	def authenticate_api_v1_user!(options = {})
		byebug 
		if user_signed_in? 
			super(options)
		else
			render json: { error: "You are not logged in." }, status: :unauthorized
		end 	
	end

	# def authenticate_admin!(options = {})
	# 	if admin_signed_in? 
	# 		super(options)
	# 	else
	# 		render json: { error: "You are not logged in." }, status: :unauthorized
	# 	end 	
	# end
end