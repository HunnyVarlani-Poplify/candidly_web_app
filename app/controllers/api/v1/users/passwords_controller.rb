module Api
  module V1
    class Users::PasswordsController < Devise::PasswordsController
      respond_to :json
    end
  end
end
