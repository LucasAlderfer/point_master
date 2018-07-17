require 'rails_helper'

describe 'as an admin' do
  it 'can create a new badge' do
    admin = Admin.create(name:'billy', email:'an@email', password:'password_2')

    visit '/'

    click_link "Login"

    fill_in :email, with: 'an@email'
    fill_in :password, with: 'password_2'

    within '#login-form' do
      click_button "Login"
    end

    visit admins_path

    click_button "Create a New Badge"

    expect(current_path).to eq(new_badge_path)

    fill_in :badge_title, with: 'new badge'

    click_button 'Create Badge'

    expect(current_path).to eq admins_path
    expect(page).to have_content("New Badge Added!")
  end
end

describe "as a user" do
  it "badges can be awarded" do
    user_1 = User.create(name:"bill", email:'anemail', password:'password')
    point_1 = user_1.points.create
    point_2 = user_1.points.create
    admin = Admin.create(name:'billy', email:'an@email', password:'password_2')
    badge = Badge.create(title:'tester')

    visit users_path

    click_link "Login"

    fill_in :email, with: 'an@email'
    fill_in :password, with: 'password_2'

    within '#login-form' do
      click_button "Login"
    end

    visit admins_path

    within "#user-id-#{user_1.id}" do
      expect(page).to have_content("Badges: None")
      select 'tester', from: :user_badge_badge_id
      click_button "Add Badge"
    end

    within "#user-id-#{user_1.id}" do
      expect(page).to have_content("Badges: tester")
    end
  end
end
