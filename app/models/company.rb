class Company < ApplicationRecord
  acts_as_tenant(:tenant)
  validates :name, presence: true
  before_validation :tenant_build
  belongs_to :user
  accepts_nested_attributes_for :user
  
  private

  def tenant_build
    t_name = name.gsub(/\s+/, '-').downcase
    t = Tenant.find_by(subdomain: t_name)
    self.tenant = t
    build_tenant(name: name, subdomain: t_name) unless tenant.present?
  end
end
