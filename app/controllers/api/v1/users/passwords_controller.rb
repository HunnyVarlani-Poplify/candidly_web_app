module Api
  module V1
    class Users::PasswordsController < Devise::PasswordsController
      def update
        
        binding.pry
        
        self.resource = resource_class.reset_password_by_token(resource_params)
        yield resource if block_given?

      end
    end
  end
end
