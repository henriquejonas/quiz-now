class QuestionSerializer < ActiveModel::Serializer
  attributes :id

  has_one :category
  has_many :answers
end
