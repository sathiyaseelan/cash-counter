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

FactoryGirl.define do
  factory :group do

    name { Faker::Team.name }
    description { Faker::Lorem.sentence }

    transient do
      admins_count 1
      members_count 0
    end

    trait :with_admins do
      after :create do |group, evaluator|
        create_list :member, evaluator.admins_count, :as_admin, group: group
      end
    end

    trait :with_members do
      after :create do |group, evaluator|
        create_list :member, evaluator.members_count, :as_member, group: group
      end
    end

  end
end
