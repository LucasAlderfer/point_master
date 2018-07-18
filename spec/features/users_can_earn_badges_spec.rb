require 'rails_helper'

describe 'as an admin' do
  it 'can create a new badge' do
    admin = User.create(name:'billy', email:'an@email', password:'password_2', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_management_index_path

    click_button "Create a New Badge"

    expect(current_path).to eq(new_badge_path)

    fill_in :badge_title, with: 'new badge'

    click_button 'Create Badge'

    expect(current_path).to eq admin_management_index_path
    expect(page).to have_content("New Badge Added!")
  end
  it 'can update a badge' do
    admin = User.create(name:'billy', email:'an@email', password:'password_2', role: 1)
    badge_1 = Badge.create(title:'old_badge')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit badges_path

    within "#badge-#{badge_1.title}" do
      click_button "Edit"
    end

    expect(current_path).to eq edit_badge_path(badge_1)

    fill_in :badge_title, with: 'new_badge'
    fill_in :badge_value, with: 3

    click_button "Create Badge"

    expect(current_path).to eq badges_path
    expect(page).to have_content 'Badge: new_badge'
    expect(page).to have_content 'Value: 3'
  end
  it 'can disable a badge' do
    admin = User.create(name:'billy', email:'an@email', password:'password_2', role: 1)
    badge_1 = Badge.create(title:'old_badge')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit badges_path

    within "#badge-#{badge_1.title}" do
      click_button "Disable"
    end

    expect(current_path).to eq badges_path

    within "#badge-#{badge_1.title}" do
      expect(page).to have_content("Currently Unavailable!")
      expect(page).to have_button('Buy Badge', disabled: true)
    end
  end
  it 'can delete a badge' do
    admin = User.create(name:'billy', email:'an@email', password:'password_2', role: 1)
    badge_1 = Badge.create(title:'old_badge')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit badges_path

    within "#badge-#{badge_1.title}" do
      click_button "Delete Badge"
    end

    expect(current_path).to eq badges_path

    expect(page).to_not have_content "Badge: #{badge_1.title}"
    expect(page).to have_content "You deleted old_badge badge!"
  end
  it 'cannot update a badge with invalid input' do
    admin = User.create(name:'billy', email:'an@email', password:'password_2', role: 1)
    badge_1 = Badge.create(title:'old_badge')
    badge_2 = Badge.create(title:'new_badge')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit badges_path

    within "#badge-#{badge_1.title}" do
      click_button "Edit"
    end

    expect(current_path).to eq edit_badge_path(badge_1)

    fill_in :badge_title, with: "new_badge"
    fill_in :badge_value, with: "3"

    click_button "Create Badge"

    expect(page).to have_content "Badge Update Could Not be Saved!"
  end
end
describe "as a user" do
  it "badges can be awarded" do
    user_1 = User.create(name:"bill", email:'anemail', password:'password')
    point_1 = user_1.points.create
    point_2 = user_1.points.create
    admin = User.create(name:'billy', email:'an@email', password:'password_2', role: 1)
    badge = Badge.create(title:'tester')

    visit users_path

    click_link "Login"

    fill_in :email, with: 'an@email'
    fill_in :password, with: 'password_2'

    within '#login-form' do
      click_button "Login"
    end

    visit admin_management_index_path

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
