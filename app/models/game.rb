class Game < ActiveRecord::Base
	extend Enumerize
	
	belongs_to :player_1, class_name: User
  belongs_to :player_2, class_name: User

  has_many :questions, -> { distinct }, through: :game_questions

  has_many :game_questions

  enumerize :status, in: [:waiting_for_players, :started, :terminated, :cancelled], default: :waiting_for_players, predicates: true, scope: true

  scope :valid_for_player,   ->(player) { with_status(:waiting_for_players).where('player_1_id = ? OR player_2_id = ?', player, player) }
  scope :current_for_player, ->(player) { with_status(:waiting_for_players, :cancelled, :started).where('player_1_id = ? OR player_2_id = ?', player, player) }
  scope :for_player, 				 ->(player) { where('player_1_id = ? OR player_2_id = ?', player, player) }

  def cancel current_user=nil
  	if !current_user.nil? && (self.player_1 == current_user || self.player_2 == current_user)
			self.status = :cancelled
			self.player_1.update_attribute(:status, :online) if self.player_1.status == :waiting
			self.player_2.update_attribute(:status, :online) if self.player_2.status == :waiting
			save
		end
  end

  def finalize current_user=nil
  	if !current_user.nil? && (self.player_1 == current_user || self.player_2 == current_user)
			self.status = :terminated
			save
		end
  end

  def player_points player=nil
  	game_questions.by_user(player).map(&:points).sum
  end

  def my_oponnent player=nil
    player == self.player_1 ? self.player_2 : self.player_1
  end

  def correct_answers player=nil
    game_questions.by_user(player).map(&:answer).select { |d| !d.nil?}.map(&:correct).select { |d| d }.count
  end

end

# == Schema Information
#
# Table name: games
#
#  id          :integer          not null, primary key
#  score_one   :float(24)
#  score_two   :float(24)
#  created_at  :datetime
#  updated_at  :datetime
#  player_1_id :integer
#  player_2_id :integer
#  status      :string(255)
#
