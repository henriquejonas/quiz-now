class GameSerializer < ActiveModel::Serializer
  attributes :id, :status

  has_one :player_1
  has_one :player_2
  
  has_many :questions
end
