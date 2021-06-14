class Company < ApplicationRecord
  acts_as_tenant(:tenant)
  validates :name, presence: true
  validates_uniqueness_of :name 
  before_validation :tenant_build
  has_one :user
  accepts_nested_attributes_for :user
  
  private

  def tenant_build
    return if tenant.present?
    
    t_name = name.gsub(/\s+/, '-').downcase
    user.tenant = self.tenant = build_tenant(name: name, subdomain: t_name)
  end
end
