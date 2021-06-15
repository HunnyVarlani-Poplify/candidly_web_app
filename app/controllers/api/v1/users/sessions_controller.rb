class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: { message: 'You are logged in.' }, status: :ok
  end

  def respond_to_on_destroy
    if current_api_v1_user
      log_out_success && return
    else
      log_out_failure
    end
  end

  def log_out_success
    cookies.delete("Authorization", domain: ".demo.localhost")
    cookies.delete("Tenant-Name", domain: ".demo.localhost")
    render json: { message: "You are logged out." }, status: :ok
  end

  def log_out_failure
    cookies.delete("Authorization", domain: ".demo.localhost")
    cookies.delete("Tenant-Name", domain: ".demo.localhost")
    render json: { message: "Hmm nothing happened."}, status: :unauthorized
  end
end