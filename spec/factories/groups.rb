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
    name {Faker::Team.name}
    description {Faker::Lorem.sentence}

    transient do
      admins_count 1
      members_count 0
    end

    after(:create) do |group, evaluator|
      create_list :member, evaluator.admins_count, group: group, role: :admin if evaluator.admins_count > 0
      create_list :member, evaluator.members_count, group: group, role: :member if evaluator.members_count > 0
    end
  end
end
