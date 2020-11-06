require "application_system_test_case"

class ActivitiesTest < ApplicationSystemTestCase
  test "visiting the index" do
    @activity = create(:activity)
    visit unit_activities_url(@activity.unit)
    assert_selector "h1", text: "Vote"
  end

  test "creating an activity" do
    sign_in
    assert_text "No activities have been proposed."
    within "#activities" do
      click_on "Propose an Activity"
    end

    assert_selector "h1", text: "What's your Activity idea?"

    fill_in "What's a good title for your activity idea?", with: Faker::Lorem.sentence(word_count: 5)
    fill_in "Number of days", with: "3"
    check "Swimming"
    check "Biking"
    click_on "Create Activity"
    assert_text "Activity was successfully created."
  end

  test "viewing an activity" do
    @activity = create(:activity)

    visit unit_activity_path(@activity.unit, @activity)
    assert_selector "h1", text: @activity.name
  end

  test "updating an activity" do
    sign_in
    activity = create(:activity, author: @user)
    visit unit_activity_path(activity.unit, activity)
    assert_text "Activity length: " + activity.duration_days
    click_on "activity-edit-link"
    fill_in "Number of days", with: '5'
    fill_in "What's a good title for your activity idea?", with: activity.name + 'New'
    click_on "Update Activity"
    assert_text "Activity was successfully updated."
    assert_selector "h1", text: activity.name
    assert_text "Activity length: 5 days"
  end

  test "destroying a activity" do
    sign_in
    activity = create(:activity, author: @user)
    visit unit_activities_path(@user.unit)
    click_on activity.name
    page.accept_confirm do
      click_on "Destroy", match: :first
    end
    assert_text "Activity was successfully destroyed"
    has_no_link? activity.name
  end

  test "copying an activity from another unit" do
    activity = create(:activity)
    user = create(:user, is_owner: true)
    sign_in(user)
    click_on "brand-logo"
    click_on activity.unit.name
    click_on activity.name
    click_on "copy-activity-link"
    assert_selector "h1", text: "Vote"
    assert_text "Activity '#{activity.name}' copied to your Unit."
    click_on activity.name
  end
end
