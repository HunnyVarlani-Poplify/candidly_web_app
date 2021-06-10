class Tenant < ApplicationRecord
  has_one :company
end
