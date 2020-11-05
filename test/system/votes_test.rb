require "application_system_test_case"

class VotesTest < ApplicationSystemTestCase
  test "unit user placing votes" do
    user = create(:user)
    unit = user.unit
    activities = create_list(:activity, 3, author_id: user.id, unit: unit)
    assert_equal 0, user.votes_count
    sign_in(user)
    visit root_url
    click_on user.unit.name
    click_on "place-vote-#{activities[0].id}"
    assert_equal 1, user.reload.votes_count
    assert_selector "#votes-available", text: user.votes_available
    click_on "place-vote-#{activities[1].id}"
    click_on "place-vote-#{activities[1].id}"
    click_on "place-vote-#{activities[2].id}"
    click_on "place-vote-#{activities[1].id}"
    click_on "place-vote-#{activities[1].id}"
    click_on "place-vote-#{activities[2].id}"
    click_on "remove-vote-#{activities[0].id}"
    click_on "remove-vote-#{activities[2].id}"
    assert_equal 5, user.reload.votes_count
    assert_selector "#votes-available", text: user.votes_available
    assert_selector "#activity-#{activities[0].id}-total-count", text: "0"
    assert_selector "#activity-#{activities[1].id}-total-count", text: "4"
    assert_selector "#activity-#{activities[2].id}-total-count", text: "1"
  end

  test "user unable to place votes on other units" do
    user_1 = create(:user)
    unit_1 = user_1.unit
    user_2 = create(:user)
    unit_2 = user_2.unit
    activities = create_list(:activity, 5, author_id: user_1.id, unit: unit_1)
    sign_in(user_2)
    visit root_url
    activities[0].votes.create(user: user_1)
    click_on user_1.unit.name
    assert_selector "#activity-#{activities[0].id}-total-count", text: "1"
    assert_no_selector "place-vote-#{activities[1].id}"
    assert_no_selector "remove-vote-#{activities[1].id}"
  end
end