class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email

  self.root = "user"

  def full_name
    "#{first_name} #{last_name}"
  end
end
