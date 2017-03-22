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

FactoryGirl.define do
  factory :expense do

    description { Faker::Lorem.sentence }
    amount { Faker::Number.decimal(2) }
    paid_on { Faker::Date.between(2.days.ago, Date.today) }
    group  nil
    paid_by nil

    transient do
      categories_count 1
    end

    trait :with_common_categories do
      before :create do |expense, evaluator|
        create_list :category, evaluator.categories_count
      end
    end

    trait :with_group_categories do
      before :create do |expense, evaluator|
        create_list :group_category, evaluator.categories_count, group_id: expense.group.id if evaluator.categories_count > 0
      end
    end
    after :create do |expense, evaluator|
      expense.categories << expense.group.categories.limit(3)
    end
  end
end
