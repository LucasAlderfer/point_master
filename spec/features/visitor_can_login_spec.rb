require 'rails_helper'

describe "visiting /" do
  context "as a visitor" do
    it "can access the login page and log in" do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      visit users_path

      click_link "Login"

      expect(current_path).to eq(login_path)

      fill_in :email, with: user_1.email
      fill_in :password, with: user_1.password

      within '#login-form' do
        click_button "Login"
      end

      expect(current_path).to eq(user_path(user_1))
    end
    it 'cannot log in without valid credentials' do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      visit login_path

      fill_in :email, with: user_1.email
      fill_in :password, with: 'hello'

      within '#login-form' do
        click_button "Login"
      end

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry that email and password combination is invalid")
    end
    it "can maintain a user's session after login" do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      visit login_path

      fill_in :email, with: user_1.email
      fill_in :password, with: user_1.password

      within '#login-form' do
        click_button "Login"
      end

      expect(current_path).to eq(user_path(user_1))
      visit users_path
      click_link "My Profile"
      expect(current_path).to eq(user_path(user_1))
    end
    it "cannot access profile before being logged in" do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')

      visit users_path

      expect(page).to_not have_button("My Profile")
    end
    it "cannot access profile after logging out" do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      visit login_path

      fill_in :email, with: user_1.email
      fill_in :password, with: user_1.password

      within '#login-form' do
        click_button "Login"
      end

      within '#nav-bar' do
        click_link "Logout"
      end
      expect(page).to have_content("You have been logged out!")
      visit users_path

      expect(page).to_not have_button("My Profile")
    end
    it 'cannot access any admin pages' do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')

      visit login_path

      fill_in :email, with: user_1.email
      fill_in :password, with: user_1.password

      within '#login-form' do
        click_button "Login"
      end

      click_link "Home"

      expect(current_path).to eq(users_path)

      visit admin_management_index_path

      expect(page).to have_content "The page you were looking for doesn't exist."
      expect(page).to_not have_content "Create a New Badge"
    end
    it "can see user's active points on it's home page" do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create
      expected = 3

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit user_path(user_1)

      expect(page).to have_content("Current Points: #{expected}")
    end
    it "can see user's total erned points on it's home page" do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create
      user_1.redeem_points(2)
      expected_1 = 1
      expected_2 = 3

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit user_path(user_1)

      expect(page).to have_content("Current Points: #{expected_1}")
      expect(page).to have_content("Total Points Earned: #{expected_2}")
    end
    it "can see user's spent points on it's home page" do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create
      user_1.redeem_points(2)
      expected_1 = 1
      expected_2 = 2

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit user_path(user_1)

      expect(page).to have_content("Current Points: #{expected_1}")
      expect(page).to have_content("Points Spent: #{expected_2}")
    end
    it "can see user's badges on it's home page" do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      badge_1 = Badge.create(title:'tester')
      user_1.user_badges.create(badge: badge_1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit user_path(user_1)

      expect(page).to have_content("Badges: #{user_1.badge_display}")
    end
  end
end
