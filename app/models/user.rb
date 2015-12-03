class User < ActiveRecord::Base
  extend Enumerize

  has_secure_password

  validates :email, presence: true, uniqueness: true, email: true, length: {maximum: 100}
  validates :uid, presence: true, if: 'provider.present?'
  validates :password, length: {minimum: 4, maximum: 16}, allow_blank: true

  has_many :trains
  has_many :player_1_games, foreign_key: :player_1_id, class_name: Game
  has_many :player_2_games, foreign_key: :player_2_id, class_name: Game

  enumerize :status, in: [:online, :offline, :playing, :waiting, :searching], default: :offline, predicates: true, scope: true

  scope :not_user, ->(user) { where('id != ?', user.id) }

  def create_omniauth(info)
    self.email = info['info']['email']
    self.provider = info['provider']
    self.uid = info['uid']
    self.password_digest = BCrypt::Password.create SecureRandom.urlsafe_base64
  end

  def games
    player_1_games.with_status(:terminated) + player_2_games.with_status(:terminated)
  end
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
#  status          :string(255)
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
