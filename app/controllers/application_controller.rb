class ApplicationController < ActionController::API
	set_current_tenant_by_subdomain(:tenant, :subdomain)

	def authenticate_user!(options = {})
		if user_signed_in? 
			super(options)
		else
			render json: { error: "You are not logged in." }, status: :unauthorized
		end 	
	end

	def authenticate_admin!(options = {})
		if admin_signed_in? 
			super(options)
		else
			render json: { error: "You are not logged in." }, status: :unauthorized
		end 	
	end
end