require 'rails_helper'

describe "visiting /" do
  context "as a visitor" do
    it "can access the login page and log in" do
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      visit users_path

      click_button "Login"

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
      click_button "My Profile"
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
        click_button "Logout"
      end
      expect(page).to have_content("You have been logged out!")
      visit users_path

      expect(page).to_not have_button("My Profile")
    end
    it 'cannot access any admin pages' do
      admin = Admin.create(name:'billy', email:'an@email', password:'password_2')
      user_1 = User.create(name:'bill', email:'anemail', password:'password')

      visit login_path

      fill_in :email, with: user_1.email
      fill_in :password, with: user_1.password

      within '#login-form' do
        click_button "Login"
      end

      click_button "Home"

      expect(current_path).to eq(users_path)

      visit admins_path

      expect(current_path).to eq(users_path)
    end
    it "can see user's points on it's home page" do
      admin = Admin.create(name:'billy', email:'an@email', password:'password_2')
      user_1 = User.create(name:'bill', email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create
      expected = 3

      visit login_path

      fill_in :email, with: user_1.email
      fill_in :password, with: user_1.password

      within '#login-form' do
        click_button "Login"
      end

      expect(page).to have_content("Points: #{expected}")
    end
  end
end
