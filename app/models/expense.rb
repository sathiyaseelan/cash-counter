# == Schema Information
#
# Table name: expenses
#
#  id          :integer          not null, primary key
#  description :text
#  amount      :decimal(, )
#  paid_on     :datetime
#  paid_by_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  group_id    :integer
#

class Expense < ApplicationRecord
  validate :paid_by_member_of_group
  belongs_to :group
  belongs_to :paid_by, class_name: "Member"
  has_and_belongs_to_many :categories, join_table: :expenses_categories

  def paid_by_member_of_group
    unless self.group.members.include? self.paid_by
      errors.add(:paid_by, "is not the member of the group")
    end
  end

end
