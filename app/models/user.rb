class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true, email: true, length: {maximum: 100}
  validates :uid, presence: true, if: 'provider.present?'
  validates :password, length: {minimum: 4, maximum: 16}, allow_blank: true
end
