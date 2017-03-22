# == Schema Information
#
# Table name: categories
#
#  id               :integer          not null, primary key
#  name             :string
#  belongs_to_group :boolean
#  group_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do

  factory :category do
    name { Faker::Lorem.word }
    group_id nil
    belongs_to_group false

    factory :group_category do
      belongs_to_group true
    end
  end

end
