require 'rails_helper'

describe 'visiting /badge-store' do
  context "as a user" do
    it "cannot redeem points for a badge without enough points" do
      user_1 = User.create!(name:"bill", email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      badge_1 = Badge.create(title:'tester')
      user_1.user_badges.create(badge: badge_1)
      badge_2 = Badge.create(title:'big_roller', value: 5)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/badge-store'

      expect(page).to have_content "Current Points: #{user_1.point_count}"

      within "#badge-#{badge_2.title}" do
        click_button "Buy Badge"
      end

      expect(current_path).to eq '/badge-store'
      expect(page).to have_content "You do not have enough points to buy that badge!"
    end
    it "can redeem points for a badge with enough points" do
      user_1 = User.create!(name:"bill", email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create
      point_4 = user_1.points.create
      point_5 = user_1.points.create
      badge_1 = Badge.create(title:'tester')
      user_1.user_badges.create(badge: badge_1)
      badge_2 = Badge.create(title:'big_roller', value: 5)
      expected_1 = user_1.point_count
      expected_2 = (user_1.point_count - badge_2.value)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/badge-store'

      expect(page).to have_content "Current Points: #{expected_1}"

      within "#badge-#{badge_2.title}" do
        click_button "Buy Badge"
      end

      expect(current_path).to eq user_path(user_1)
      expect(page).to have_content "#{badge_2.title} Badge Added!"
      expect(page).to have_content "Badges: #{user_1.badge_display}"
      expect(page).to have_content "Points: #{expected_2}"
    end
    it "cannot redeem points for a badge with enough points if the user already has that badge" do
      user_1 = User.create!(name:"bill", email:'anemail', password:'password')
      point_1 = user_1.points.create
      point_2 = user_1.points.create
      point_3 = user_1.points.create
      point_4 = user_1.points.create
      point_5 = user_1.points.create
      badge_1 = Badge.create(title:'tester', value: 1)
      user_1.user_badges.create(badge: badge_1)
      badge_2 = Badge.create(title:'big_roller', value: 5)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/badge-store'

      within "#badge-#{badge_1.title}" do
        expect(page).to have_button('Buy Badge', disabled: true)
      end
    end
  end
end
