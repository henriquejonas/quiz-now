class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true, email: true, length: {maximum: 100}
  validates :uid, presence: true, if: 'provider.present?'
  validates :password, length: {minimum: 4, maximum: 16}, allow_blank: true
end

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  name            :string(255)
#  provider        :string(255)
#  uid             :string(255)
#  password_digest :string(255)
#  last_access_ip  :string(255)
#  last_access_at  :datetime
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
