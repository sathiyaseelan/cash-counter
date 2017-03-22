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

    trait :as_member do
      role :member
    end

    trait :as_admin do
      role :admin
    end

  end
end
