class Company < ApplicationRecord
  acts_as_tenant(:tenant)
  validates :name, presence: true
  before_validation :tenant_build, :associate_tenant_with_admin
  belongs_to :admin
  accepts_nested_attributes_for :admin
  
  private

  def tenant_build
    tenant_name = name.gsub(/\s+/, '-').downcase
    build_tenant(name: name, subdomain: tenant_name)
  end

  def associate_tenant_with_admin
    return if admin.tenant.present?
    
    admin.password = '12345678A'
    admin.tenant = tenant
  end
end
