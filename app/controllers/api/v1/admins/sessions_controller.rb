class Api::V1::Admins::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: { message: 'You are logged in.' }, status: :ok
  end


  def respond_to_on_destroy  
    request.headers['HTTP_AUTHORIZATION'] = "Bearer "+request.cookies["Authorization"]   
    if current_api_v1_admin
      cookies.delete("Authorization", domain: ".demo.localhost")
      cookies.delete("Tenant-Name", domain: ".demo.localhost")
      log_out_success && return
    else
      log_out_failure
    end
  end

  def log_out_success
    render json: { message: "You are logged out." }, status: :ok
  end

  def log_out_failure 
    render json: { message: "Hmm nothing happened."}, status: :unauthorized
  end
end