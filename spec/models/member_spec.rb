# == Schema Information
#
# Table name: members
#
#  id       :integer          not null, primary key
#  user_id  :integer
#  group_id :integer
#  role     :string
#

require 'rails_helper'

RSpec.describe Member, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
