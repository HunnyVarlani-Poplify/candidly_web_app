class Company < ApplicationRecord
  acts_as_tenant(:tenant)
  validates :name, presence: true
  before_validation :tenant_build

  private

  def tenant_build
    tenant_name = name.gsub(/\s+/, '-').downcase
    build_tenant(name: name, subdomain: tenant_name)
  end
end
