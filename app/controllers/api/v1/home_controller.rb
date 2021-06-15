class Api::V1::HomeController < ApplicationController
	before_action :authenticate_api_v1_user!, only: [:list_of_domains]

	def sign_in_user
		auth_options = sign_in_params
		resource = Admin.find_by(email: auth_options[:email].downcase)
		resource ||= User.find_by(email: auth_options[:email].downcase)

		if resource.present? && resource.valid_password?(auth_options[:password])
			sign_in(resource)
			respond_with resource
		else
			render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unauthorized
		end
	end

	def list_of_domains 
		if current_api_v1_user.present? 
			render json: { domains: Tenant.all.select(:id, :name, :subdomain) }, status: :ok		
		end
	end

	private 
		def sign_in_params 
			params.require(:user).permit(:email, :password)
		end

		def respond_with(resource, _opts = {})
			response["Tenant-Name"] = resource.subdomain   
			cookies["Authorization"] = {value:	resource.get_jwt_token, httponly: true, same_site: "None", secure: true, domain: ".demo.localhost"}
      cookies["Tenant-Name"] = {value: resource.subdomain, httponly: true, same_site: "None", secure: true, domain: ".demo.localhost"}
			if resource.class == Admin 
			 	render json: AdminSerializer.new(resource), status: :ok
			else 
				render json: UserSerializer.new(resource), status: :ok
			end
		end
end
