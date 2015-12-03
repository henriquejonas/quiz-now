class GameSerializer < ActiveModel::Serializer
  attributes :id, :status, :player_1_points, :player_2_points

  has_one :player_1
  has_one :player_2
  
  has_many :questions

  def player_1_points
  	object.game_questions.by_user(object.player_1).map(&:points).sum
  end

  def player_2_points
  	object.game_questions.by_user(object.player_2).map(&:points).sum
  end

end
