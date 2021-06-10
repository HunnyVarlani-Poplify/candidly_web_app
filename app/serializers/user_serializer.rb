class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email

  attribute :company_name do |object|
    object.company.name
  end

  attribute :subdomain do |object|
    object.tenant.subdomain
  end

end
