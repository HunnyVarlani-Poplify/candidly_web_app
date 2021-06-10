class AllowlistedJwt < ApplicationRecord
  belongs_to :business, polymorphic: true
end