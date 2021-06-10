module Api
  module V1
    class BaseApiController < ActionController::API
      before_action :authenticate_api_v1_admin!
      set_current_tenant_by_subdomain(:tenant, :subdomain)
    end
  end
end
