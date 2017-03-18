# == Schema Information
#
# Table name: members
#
#  id       :integer          not null, primary key
#  user_id  :integer
#  group_id :integer
#  role     :string           default("member")
#

FactoryGirl.define do
  factory :member do
    user
    group
    role :member
  end
end
