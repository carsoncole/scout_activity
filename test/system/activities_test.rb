require "application_system_test_case"

class ActivitiesTest < ApplicationSystemTestCase
  test "visiting the index" do
    @activity = create(:activity)
    visit unit_activities_url(@activity.unit)
    assert_selector "h1", text: "Vote"
  end

  test "creating an activity" do
    sign_in
    assert_text "No activities have been pr\oposed."
    click_on "Propose an Activity"

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
    @activity = create(:activity, author: @user)
    visit unit_activity_path(@activity.unit, @activity)
    click_on "activity-edit-link"
    fill_in "Number of days", with: '5'
    click_on "Update Activity"
    assert_text "Activity was successfully updated."
  end

  test "destroying a Activity" do
    sign_in
    @activity = create(:activity, author: @user)
    visit unit_activity_path(@activity.unit, @activity)
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Activity was successfully destroyed"
  end
end
