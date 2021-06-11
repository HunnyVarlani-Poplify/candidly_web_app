class Company < ApplicationRecord
  acts_as_tenant(:tenant)
  validates :name, presence: true
  validates_uniqueness_of :name 
  before_validation :tenant_build
  has_one :user
  accepts_nested_attributes_for :user
  
  private

  def tenant_build
    t_name = name.gsub(/\s+/, '-').downcase
    tnt = Tenant.find_or_create_by(name: name, subdomain: t_name)
    self.tenant = user.tenant = tnt
  end
end
