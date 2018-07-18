require 'rails_helper'


describe Badge do
  describe 'validations' do
    it 'is invalid without a title' do
      badge = Badge.create()
      expect(badge).to_not be_valid
    end
    it 'is valid with a title' do
      badge = Badge.create(title:'title')
      expect(badge).to be_valid
    end
  end

  describe "relationships" do
    it "has many user_badges" do
      badge = Badge.create(title:'title')
      expect(badge).to respond_to(:user_badges)
    end
    it "has many users" do
      badge = Badge.create(title:'title')
      expect(badge).to respond_to(:users)
    end
  end

  describe 'instance method' do
    it "can be disabled" do
      badge = Badge.create(title:'title')
      badge.enable_badge
      expect(badge.enabled).to eq false
    end
    it "can be enabled" do
      badge = Badge.create(title:'title', enabled: false)
      badge.enable_badge
      expect(badge.enabled).to eq true
    end
  end
end
