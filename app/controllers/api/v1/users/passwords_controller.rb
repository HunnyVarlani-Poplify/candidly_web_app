module Api
  module V1
    class Users::PasswordsController < Devise::PasswordsController
      respond_to :json
      
      private
      
      def respond_with(resource, _opts = {})
        response["Tenant-Name"] = resource.subdomain   
        cookies["Authorization"] = {value:	resource.get_jwt_token, httponly: true, same_site: "None", secure: true, domain: ".cand.localhost"}
        cookies["Tenant-Name"] = {value: resource.subdomain, httponly: true, same_site: "None", secure: true, domain: ".cand.localhost"}
        if resource.class == Admin 
           render json: AdminSerializer.new(resource), status: :ok
        else 
          render json: UserSerializer.new(resource), status: :ok
        end
      end 
    end
  end
end
