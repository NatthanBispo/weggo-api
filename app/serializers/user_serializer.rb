class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :token, :name, :created_at

  def token
    scope[:token] if scope.present?
  end

end
