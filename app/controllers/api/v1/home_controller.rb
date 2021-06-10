class Api::V1::HomeController < ApplicationController
	before_action :authenticate_user!, only: [:list_of_domains]

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
		if current_user.present? 
			render json: { domains: Tenant.all.select(:id, :name, :subdomain) }, status: :ok		
		end
	end

	private 
		def sign_in_params 
			params.require(:user).permit(:email, :password)
		end

		def respond_with(resource, _opts = {})
			response["Tenant-Name"] = resource.subdomain 
			if resource.class == Admin 
			 	render json: AdminSerializer.new(resource), status: :ok
			else 
				render json: UserSerializer.new(resource), status: :ok
			end
		end
end
