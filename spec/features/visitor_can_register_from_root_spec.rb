require 'rails_helper'

describe "visiting /" do
  context "as a visitor" do
    it "can create a new user" do
      visit users_path

      click_button "New User"

      expect(current_path).to eq new_user_path

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

      expect(current_path).to eq new_user_path
      expect(page).to have_content("All fields are required! No duplicate accounts allowed!")
    end
  end
  context "as a user" do
    it "can see all users, their current points and badges" do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      user_2 = User.create(name:'jane', email:'emalia', password:'password')
      point_1 = user_1.points.create
      point_2 = user_2.points.create
      point_3 = user_2.points.create
      badge_1 = Badge.create(title:'tester')
      user_1.user_badges.create(badge: badge_1)
      badge_2 = Badge.create(title:'veteran')
      user_2.user_badges.create(badge: badge_1)
      user_2.user_badges.create(badge: badge_2)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit users_path

      expect(page).to have_content "Name: #{user_1.name}"
      expect(page).to have_content "Name: #{user_2.name}"
      expect(page).to have_content "Badges: #{user_1.badge_display}"
      expect(page).to have_content "Badges: #{user_2.badge_display}"
      expect(page).to have_content "Point Count: #{user_1.point_count}"
      expect(page).to have_content "Point Count: #{user_2.point_count}"
    end
  end
end
