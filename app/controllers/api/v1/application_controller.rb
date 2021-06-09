module Api
  module V1
    class ApplicationController < ActionController::API
      include ActionController::MimeResponds
      include ActionController::Cookies 
      
      def encode_token(payload, expiration)
        payload[:exp] = expiration
        JWT.encode payload, DEVISE_SECRET, 'HS256'
      end

      def decode_token
        token = request.headers["Authorization"]
        decode_token =  
          begin 
            JWT.decode token, DEVISE_SECRET, true, { algorithm: 'HS256' }
          rescue 
              
          end
      end
      
      def after_sign_in_path_for(resource)
        byebug 
      end
    end
  end
end