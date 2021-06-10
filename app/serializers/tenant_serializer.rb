class TenantSerializer
  include JSONAPI::Serializer
  attributes :name, :subdomain

  has_one :company
end
