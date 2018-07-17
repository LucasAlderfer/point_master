require 'rails_helper'

describe "visiting /" do
  context "as a visitor" do
    it "can create a new user" do
      visit users_path

      click_button "New User"

      expect(current_path).to eq users_registration_path

      fill_in :user_name, with: "new_user"
      fill_in :user_email, with: "email@email.test"
      fill_in :user_password, with: "password_12345"

      click_button "Create User"

      expect(current_path).to eq user_path(User.last)
      expect(page).to have_content("Name: new_user")
      expect(page).to have_content("Email: email@email.test")
    end
    it "cannot create a duplicate user" do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      visit users_path

      click_button "New User"

      fill_in :user_name, with: "new_user"
      fill_in :user_email, with: "anemail"
      fill_in :user_password, with: "password_12345"

      click_button "Create User"

      expect(current_path).to eq users_registration_path
      expect(page).to have_content("All fields are required! No duplicate accounts allowed!")
    end
  end
end
