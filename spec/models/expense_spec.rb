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

require 'rails_helper'

RSpec.describe Expense, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
