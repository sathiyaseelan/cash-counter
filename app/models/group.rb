# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Group < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :expenses, dependent: :destroy
  
  def only_members
    members.only_members
  end

  def admins
    members.admins
  end

  def categories
    Category.where(group_id: self.id)
  end

end
