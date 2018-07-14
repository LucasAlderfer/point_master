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
  describe 'class methods' do
    it 'can authenticate members' do
      user = User.create!(name:"bill", email:'anemail', password:'password')
      auth = User.authenticate('anemail', 'password')
      expect(auth).to eq(user)
    end
    it "won't authenticate non-members" do
      user = User.create!(name:"bill", email:'anemail', password:'password')
      auth = User.authenticate('anemail', 'password_1')
      expect(auth).to eq(nil)
    end
  end
  describe 'instance methods' do
    it 'can count its points' do
      user_1 = User.create!(name:"bill", email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create
      expected = user_1.points.count

      expect(user_1.point_count).to eq expected
    end
  end
end
