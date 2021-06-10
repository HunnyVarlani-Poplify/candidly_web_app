class CompanySerializer
  include JSONAPI::Serializer
  attributes :name, :address, :website, :contact_no
  # belongs_to :tenant
  # belongs_to :company
  attribute :tenant_name do |object|
    object.tenant.name
  end

  attribute :tenant_subdomain do |object|
    object.tenant.subdomain
  end
end
