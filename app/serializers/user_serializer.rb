class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :status
end
