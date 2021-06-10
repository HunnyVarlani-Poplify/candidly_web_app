class ApplicationController < ActionController::API

	def authenticate_api_v1_user!(options = {})  
		if api_v1_user_signed_in? 
			super(options)
		else
			render json: { error: "You are not logged in." }, status: :unauthorized
		end 	
	end

	def authenticate_admin!(options = {})
		if api_v1_admin_signed_in? 
			super(options)
		else
			render json: { error: "You are not logged in." }, status: :unauthorized
		end 	
	end
end