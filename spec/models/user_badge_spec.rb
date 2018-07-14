require 'rails_helper'

describe UserBadge, type: :model do
  describe 'relationships' do
    it 'belongs_to a user' do
      user = User.create!(name:"bill", email:'anemail', password:'password')
      badge = Badge.create!(name:'new', value:1)
      userbadge = user.user_badges.create!(badge:badge)
      expect(userbadge).to respond_to(:user)
    end
  end
end
