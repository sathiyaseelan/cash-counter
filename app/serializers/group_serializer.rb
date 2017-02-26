class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description


  has_many :members

  has_many :admins

  def members
    object.only_members
  end

end
