require 'rails_helper'

describe "visiting /" do
  context "as an admin" do
    it "can access the login page and log in" do
      admin = User.create(name:'billy', email:'an@email', password:'password_2', role: 1)
      visit users_path

      click_link "Login"

      fill_in :email, with: 'an@email'
      fill_in :password, with: 'password_2'

      within '#login-form' do
        click_button "Login"
      end

      expect(current_path).to eq(admin_management_index_path)
    end
    it 'can access the admin home page by clicking the Home link' do
      admin = User.create(name:'billy', email:'an@email', password:'password_2', role: 1)
      visit users_path

      click_link "Login"

      fill_in :email, with: 'an@email'
      fill_in :password, with: 'password_2'

      within '#login-form' do
        click_button "Login"
      end

      visit users_path

      expect(current_path).to eq(users_path)

      click_link "Home"

      expect(current_path).to eq(admin_management_index_path)
    end
  end
end
