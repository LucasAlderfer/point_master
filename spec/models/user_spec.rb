require 'rails_helper'

describe User do
  describe "validations" do
    it "is invalid without a name" do
      user = User.create(email:'anemail', password:'password')
      expect(user).to_not be_valid
    end
    it "is invalid without an email" do
      user = User.create(name:'bill', password:'password')
      expect(user).to_not be_valid
    end
    it "is invalid without a password" do
      user = User.create(name:'bill', email:'anemail')
      expect(user).to_not be_valid
    end
    it 'is valid with a name, email and password' do
      user = User.create(name:'bill', email:'anemail', password:'password')
      expect(user).to be_valid
    end
    it 'is invalid with a duplicate email address' do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      user_2 = User.create(name:'bill', email:'anemail', password:'password')
      expect(user_2).to_not be_valid
    end
  end
  describe 'roles' do
    it 'can be created as an Admin' do
      user = User.create(name:'admin', email:'testemail', password:'adminspassword', role: 1)

      expect(user.role).to eq('admin')
      expect(user.admin?).to be_truthy
    end
    it 'can be created as a default user' do
      user = User.create(name:'default', email:'testemail', password:'userspassword')

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end
  end
  describe "relationships" do
    it "has many points" do
      user = User.create!(name:"bill", email:'anemail', password:'password')
      point = user.points.create
      expect(user).to respond_to(:points)
    end
    it "has many user_badges" do
      user = User.new(name:"bill", email:'anemail', password:'password')
      expect(user).to respond_to(:user_badges)
    end
    it "has many badges" do
      user = User.new(name:"bill", email:'anemail', password:'password')
      expect(user).to respond_to(:badges)
    end
  end
  describe 'instance methods' do
    it 'can count its active points' do
      user_1 = User.create!(name:"bill", email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create
      expected = user_1.points.count

      expect(user_1.point_count).to eq expected
    end
    it 'can count its total points' do
      user_1 = User.create!(name:"bill", email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create
      user_1.redeem_points(2)
      expected = user_1.points.count

      expect(user_1.total_point_count).to eq expected
    end
    it 'can count its spent points' do
      user_1 = User.create!(name:"bill", email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create
      user_1.redeem_points(2)
      expected = user_1.points.where(active:false).count

      expect(user_1.spent_points).to eq expected
    end
    it 'can have its points deleted' do
      user_1 = User.create!(name:"bill", email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create
      expected_1 = 3
      expected_2 = 1

      expect(user_1.total_point_count).to eq 3

      user_1.delete_points(2)

      expect(user_1.total_point_count).to eq 1
    end
    it 'can display its badges' do
      user_1 = User.create!(name:"bill", email:'anemail', password:'password')
      badge_1 = Badge.create(title:'tester')
      user_1.user_badges.create(badge: badge_1)
      badge_2 = Badge.create(title:'spender')
      user_1.user_badges.create(badge: badge_2)
      expected = "tester, spender"

      expect(user_1.badge_display).to eq expected
    end
    it 'can redeem its points' do
      user_1 = User.create!(name:"bill", email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create
      badge_2 = Badge.create(title:'spender', value: 2)
      expected = (user_1.point_count - badge_2.value)

      user_1.redeem_points(badge_2.value)

      expect(user_1.point_count).to eq(expected)
    end
  end
end
