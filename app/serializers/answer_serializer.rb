class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :answer, :order, :image_url

  def image_url
  	object.image.url
  end
end
