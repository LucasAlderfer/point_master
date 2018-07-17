# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_1 = User.create!(name:"bill", email:'anemail', password:'password')
point_1 = user_1.points.create
point_2 = user_1.points.create
user_2 = User.create!(name:"joe", email:'ojinjk', password:'password')
point_3 = user_2.points.create
user_3 = User.create!(name:"james", email:'kndkj', password:'password')
admin = User.create(name:'billy', email:'test', password:'password', role: 1)
badge_1 = Badge.create(title:'tester')
badge_2 = Badge.create(title:'veteran')
