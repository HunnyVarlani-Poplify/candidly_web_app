class ApplicationController < ActionController::API
	set_current_tenant_by_subdomain(:tenant, :subdomain)

	
end