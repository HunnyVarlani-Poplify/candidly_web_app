class Tenant < ApplicationRecord
  validates_uniqueness_of :subdomain

  has_one :company
end
