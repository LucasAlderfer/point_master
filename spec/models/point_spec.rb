require 'rails_helper'

describe Point do
  describe "relationships" do
    it "belongs to a user" do
      user_1 = User.create!(name:"bill", email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create

      expect(point_1.user).to eq user_1
    end
  end
  describe 'instance methods' do
    it 'can be deactivated' do
      user_1 = User.create!(name:"bill", email:'anemail', password:'password')
      point_1 = user_1.points.create

      expect(point_1.active).to eq true

      point_1.deactivate

      expect(point_1.active).to eq false
    end
  end
end
