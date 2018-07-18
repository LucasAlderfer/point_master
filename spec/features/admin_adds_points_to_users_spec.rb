require 'rails_helper'

context "as an admin" do
  it "can add points to a user" do
    user_1 = User.create!(name:"bill", email:'anemail', password:'password')
    point_1 = user_1.points.create
    point_2 = user_1.points.create
    admin = User.create(name:'billy', email:'an@email', password:'password_2', role: 1)
    expected_1 = 2
    expected_2 = 3

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_management_index_path

    within "#user-id-#{user_1.id}" do
      expect(page).to have_content("Point Count: #{expected_1}")
      click_button "Add Point"
    end

    expect(current_path).to eq(admin_management_index_path)

    within "#user-id-#{user_1.id}" do
      expect(page).to have_content("Point Count: #{user_1.points.count}")
    end
  end
  it 'can see all users from admins_path' do
    user_1 = User.create!(name:"bill", email:'anemail', password:'password')
    point_1 = user_1.points.create
    point_2 = user_1.points.create
    user_2 = User.create!(name:"joe", email:'ojinjk', password:'password')
    point_3 = user_2.points.create
    user_3 = User.create!(name:"james", email:'kndkj', password:'password')
    admin = User.create(name:'billy', email:'an@email', password:'password_2', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_management_index_path

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
  it "can delete a user's points" do
    user_1 = User.create!(name:"bill", email:'anemail', password:'password')
    point_1 = user_1.points.create
    point_2 = user_1.points.create
    point_3 = user_1.points.create
    point_4 = user_1.points.create
    point_5 = user_1.points.create
    admin = User.create(name:'billy', email:'an@email', password:'password_2', role: 1)
    expected_1 = 3
    expected_2 = 1
    user_1.redeem_points(2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_management_index_path

    within "#user-id-#{user_1.id}" do
      expect(page).to have_content("Point Count: #{expected_1}")
      fill_in :remove_points, with: 2
      click_button "Remove Points"
    end

    expect(user_1.total_point_count).to eq 3
    expect(user_1.point_count).to eq 1
    expect(user_1.spent_points).to eq 2
  end
end
