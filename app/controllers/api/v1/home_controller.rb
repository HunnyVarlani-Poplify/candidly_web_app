class Api::V1::HomeController < ApplicationController

  	# protect_from_forgery with: :null_session
  	
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

	private 
		def sign_in_params 
			params.require(:user).permit(:email, :password)
		end

		def respond_with(resource, _opts = {})
			 render json: { message: 'You are logged in.' }, status: :ok
		end
end
