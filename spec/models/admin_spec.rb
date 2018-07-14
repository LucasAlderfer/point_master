require 'rails_helper'

describe Admin do
  describe "validations" do
    it "is invalid without a name" do
      admin = Admin.create(email:'anemail', password:'password')
      expect(admin).to_not be_valid
    end
    it "is invalid without an email" do
      admin = Admin.create(name:'bill', password:'password')
      expect(admin).to_not be_valid
    end
    it "is invalid without a password" do
      admin = Admin.create(name:'bill', email:'anemail')
      expect(admin).to_not be_valid
    end
    it 'is valid with a name, email and password' do
      admin = Admin.create(name:'bill', email:'anemail', password:'password')
      expect(admin).to be_valid
    end
    it 'is invalid with a duplicate email address' do
      admin_1 = Admin.create(name:'bill', email:'anemail', password:'password')
      admin_2 = Admin.create(name:'bill', email:'anemail', password:'password')
      expect(admin_2).to_not be_valid
    end
  end
  describe 'class methods' do
    it 'can authenticate members' do
      admin_1 = Admin.create!(name:"bill", email:'anemail', password:'password')
      auth = Admin.authenticate('anemail', 'password')
      expect(auth).to eq(admin_1)
    end
    it "won't authenticate non-members" do
      admin_1 = Admin.create!(name:"bill", email:'anemail', password:'password')
      auth = Admin.authenticate('anemail', 'password_1')
      expect(auth).to eq(nil)
    end
  end
end
