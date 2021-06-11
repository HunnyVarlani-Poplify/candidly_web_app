class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::Allowlist

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :allowlisted_jwts, foreign_key: :business_id,
                        as: :business,
                        dependent:   :destroy

  attr_accessor :skip_password_validation

  acts_as_tenant(:tenant)
  belongs_to :company

  def subdomain
    tenant&.subdomain
  end

  @@jwt_token = nil;

  def on_jwt_dispatch(token, payload)  
    super
    set_jwt_token(token)
  end

  def set_jwt_token(token)
    @@jwt_token = token
  end

  def get_jwt_token()
    @@jwt_token
  end
end
