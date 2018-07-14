require 'rails_helper'

context "as an admin" do
  it "can add points to a user" do
    user_1 = User.create!(name:"bill", email:'anemail', password:'password')
    point_1 = user_1.points.create
    point_2 = user_1.points.create
    admin = Admin.create(name:'billy', email:'an@email', password:'password_2')
    expected_1 = 2
    expected_2 = 3

    visit users_path

    click_button "Login"

    fill_in :email, with: 'an@email'
    fill_in :password, with: 'password_2'

    within '#login-form' do
      click_button "Login"
    end

    visit admins_path

    within "#user-id-#{user_1.id}" do
      expect(page).to have_content("Point Count: #{expected_1}")
      click_button "Add Point"
      expect(page).to have_content("Point Count: #{expected_2}")
    end
  end
  it 'can see all users from admins_path' do
    user_1 = User.create!(name:"bill", email:'anemail', password:'password')
    point_1 = user_1.points.create
    point_2 = user_1.points.create
    user_2 = User.create!(name:"joe", email:'ojinjk', password:'password')
    point_3 = user_2.points.create
    user_3 = User.create!(name:"james", email:'kndkj', password:'password')
    admin = Admin.create(name:'billy', email:'an@email', password:'password_2')

    visit users_path

    click_button "Login"

    fill_in :email, with: 'an@email'
    fill_in :password, with: 'password_2'

    within '#login-form' do
      click_button "Login"
    end

    visit admins_path

    within "#user-id-#{user_1.id}" do
      expect(page).to have_content("Name: #{user_1.name}")
      expect(page).to have_content("Email: #{user_1.email}")
      expect(page).to have_content("Point Count: #{user_1.point_count}")
    end
    within "#user-id-#{user_2.id}" do
      expect(page).to have_content("Name: #{user_2.name}")
      expect(page).to have_content("Email: #{user_2.email}")
      expect(page).to have_content("Point Count: #{user_2.point_count}")
    end
    within "#user-id-#{user_3.id}" do
      expect(page).to have_content("Name: #{user_3.name}")
      expect(page).to have_content("Email: #{user_3.email}")
      expect(page).to have_content("Point Count: #{user_3.point_count}")
    end
  end
end
