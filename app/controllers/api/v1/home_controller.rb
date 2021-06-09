class Api::V1::HomeController < Api::V1::ApplicationController 
  

  def sign_in_user 
    auth_options = sign_in_params
		resource = Admin.find_by(email: auth_options[:email].downcase)
		resource ||= User.find_by(email: auth_options[:email].downcase)

    if resource.present? && resource.valid_password?(auth_options[:password])
      token = encode_token({user_id: resource.id, name: resource.class}, Time.now.to_i + 86400)
      tenant_name = resource.subdomain
      cookies["Authorization"] = {value: "Bearer #{token}", httponly: true, same_site: "None", secure: true, domain: ".#{tenant_name}.localhost"}
      cookies["Tenant-Name"] = {value: tenant_name, httponly: true, same_site: "None", secure: true, domain: ".#{tenant_name}.localhost"}
      response["Authorization"] =  "Bearer #{token}"
      render json: resource, status: :ok
    else 
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unauthorized
    end
  end

  private 
  def sign_in_params
		params.require(:user).permit(:email, :password)
	end
end