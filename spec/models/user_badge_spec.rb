require 'rails_helper'

describe UserBadge, type: :model do
  describe 'relationships' do
    it 'belongs_to a user' do
      user = User.create!(name:"bill", email:'anemail', password:'password')
      badge = Badge.create!(title:'new')
      userbadge = user.user_badges.create!(badge:badge)
      expect(userbadge).to respond_to(:user)
    end
    it 'belongs_to a badge' do
      user = User.create!(name:"bill", email:'anemail', password:'password')
      badge = Badge.create!(title:'new')
      userbadge = badge.user_badges.create!(user:user)
      expect(userbadge).to respond_to(:badge)
    end
  end
end
