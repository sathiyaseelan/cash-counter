# == Schema Information
#
# Table name: members
#
#  id       :integer          not null, primary key
#  user_id  :integer
#  group_id :integer
#  role     :string
#

class Member < ApplicationRecord
  belongs_to :group
  belongs_to :user

  scope :only_members, -> { where(role: :member)}

  scope :admins, -> { where(role: :admin) }
end
