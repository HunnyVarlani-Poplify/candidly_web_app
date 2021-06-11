module Api
  module V1
    class Users::PasswordsController < Devise::PasswordsController
      def update
        self.resource = resource_class.reset_password_by_token(resource_params)
        yield resource if block_given?
    
        if resource.errors.empty?
          resource.unlock_access! if unlockable?(resource)
          if Devise.sign_in_after_reset_password
            message = resource.active_for_authentication? ? :updated : :updated_not_active
            resource.after_database_authentication
            response = sign_in(resource_name, resource, by_pass: true)
            message = I18n.t("devise.passwords.#{message}")
          else
            message = I18n.t('devise.passwords.updated_not_active')
          end
        else
          set_minimum_password_length
        end
        render json: {message: message}
      end
    end
  end
end
