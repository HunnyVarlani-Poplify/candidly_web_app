class CompanySerializer
  include JSONAPI::Serializer
  attributes :name, :address, :website, :contact_no, :tenant, :admin
  belongs_to :tenant
  belongs_to :admin
end
