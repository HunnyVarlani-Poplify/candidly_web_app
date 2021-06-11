class CompanySerializer
  include JSONAPI::Serializer
  attributes :name, :address, :website, :contact_no, :user, :tenant
  belongs_to :tenant
  has_one :user
end
