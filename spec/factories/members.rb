FactoryGirl.define do
  factory :member do
    user
    group
    role :member
  end
end
