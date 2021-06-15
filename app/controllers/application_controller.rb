class ApplicationController < ActionController::API
	include ActionController::Cookies
	before_action :set_auth_headers
	set_current_tenant_by_subdomain(:tenant, :subdomain)

	def authenticate_api_v1_user!(options = {})  
		if api_v1_user_signed_in? 
			super(options)
		else
			render json: { error: "You are not logged in." }, status: :unauthorized
		end 	
	end

	def authenticate_api_v1_admin!(options = {}) 
		if api_v1_admin_signed_in? 
			super(options)
		else
			render json: { error: "You are not logged in." }, status: :unauthorized
		end 	
	end

	protected

	def set_auth_headers
		request.headers['HTTP_AUTHORIZATION'] = "Bearer "+request.cookies["Authorization"] if request.cookies["Authorization"].present?
	end
end