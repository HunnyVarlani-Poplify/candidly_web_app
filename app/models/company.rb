class Company < ApplicationRecord
  acts_as_tenant(:tenant)
end
