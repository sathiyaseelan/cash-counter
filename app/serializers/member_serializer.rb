class MemberSerializer < ActiveModel::Serializer
  attributes :id, :role, :email, :full_name

  def full_name
    "#{object.user.first_name}, #{object.user.last_name}"
  end
  def email
    "#{object.user.email}"
  end
end
