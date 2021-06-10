class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::Allowlist

  has_many :allowlisted_jwts, foreign_key: :business_id,
                        as: :business,
                        dependent:   :destroy


  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :jwt_authenticatable, jwt_revocation_strategy: self

  acts_as_tenant(:tenant)  

  
  
  def subdomain 
    tenant&.subdomain
  end

  def on_jwt_dispatch(token, payload)  
    super
  end  
end