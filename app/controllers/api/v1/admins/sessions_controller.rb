# frozen_string_literal: true
module Api
  module V1 
    module Admins  
      class SessionsController < Devise::SessionsController
        protect_from_forgery with: :null_session
        skip_before_action :verify_signed_out_user, only: [:destroy]

        # GET /resource/sign_in
        # def new
        #   super
        # end

        # POST /resource/sign_in
        # def create
        #   super
        # end

        # DELETE /resource/sign_out
        def destroy 
          byebug 
        end

        # protected

        # If you have extra params to permit, append them to the sanitizer.
        # def configure_sign_in_params
        #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
        # end
      end
    end
  end
end
