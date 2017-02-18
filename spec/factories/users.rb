# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           default(""), not null
#  first_name      :string           default(""), not null
#  last_name       :string           default(""), not null
#  mobile          :string           default(""), not null
#  password_digest :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    mobile Faker::Number.number(10)
    email Faker::Internet.email
    password Faker::Internet.password
    password_confirmation {password}
    
  end
end
