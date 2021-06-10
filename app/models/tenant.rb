class Tenant < ApplicationRecord
  validates_uniqueness_of :subdomain
  validates :subdomain, exclusion: { in: %w( www admin test public private staging app web demo net ),
    message: "%{value} is reserved." }

  has_one :company
end
