require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creating users
5.times do
  User.create( { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, mobile: Faker::Number.number(10), password: Faker::Internet.password , email: Faker::Internet.email} )
end


5.times do
  Group.create({name: Faker::Team.name, description: Faker::Lorem.sentence})
end
group_ids = Group.all.ids
10.times do
  Member.create( {user_id: Faker::Number.between(1,User.all.size), group_id: group_ids.sample, role: [:member, :admin].sample})
end

4.times do
  Category.create(name: Faker::Color.color_name)
end


4.times do
  Category.create(name: Faker::Color.color_name, group_id: group_ids.sample)
end
