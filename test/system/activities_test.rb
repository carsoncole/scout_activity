require "application_system_test_case"

class ActivitiesTest < ApplicationSystemTestCase
  test "activities index (not logged in)" do
    activity = create(:activity)
    visit unit_activities_url(activity.unit)
    assert_selector "h1", text: activity.unit.name + " Activity Vote"
    has_button? "Sign in or sign up to vote"
    assert_selector "ul.activities li", count: 1
    has_link? activity.name
    click_link activity.name
  end

  test "showing an activity (not logged in)" do
    activity = create(:activity)
    visit unit_activity_url(activity.unit, activity)
    assert_selector "h1", text: activity.name
    assert_no_selector "#activity-edit-link"
    assert_no_selector "#copy-activity-link"
    assert_no_selector "#archive-button"
    assert_no_selector "#destroy-button"
  end

  test "activity action buttons for user not in a unit" do
    activity = create(:activity)
    
    sign_in
    visit unit_activity_path(activity.unit, activity)
    assert_no_selector "#activity-edit-link"
    assert_no_selector "#copy-activity-link"
    assert_no_selector "#archive-button"
    assert_no_selector "#destroy-button"
  end

  test "editing an activity (as author)" do
    sign_in
    activity = create(:activity, author: @user)
    visit unit_activity_path(activity.unit, activity)

    assert_selector "#activity-edit-link"
    assert_no_selector "#copy-activity-link"
    assert_selector "#archive-button"
    assert_selector "#destroy-button"

    assert_text activity.duration_days + ' day'
    click_on "activity-edit-link"
    fill_in "Number of days", with: '5'
    fill_in "What's a good title for your activity idea?", with: activity.name + 'New'
    click_on "Update Activity"
    assert_text "Activity was successfully updated."
    assert_selector "h1", text: activity.name
    assert_text "5 days"
  end

  test "editing an activity (as admin)" do
    activity = create(:activity)
    admin = create(:admin_user, unit: activity.unit)
    sign_in(admin)
    visit unit_activity_url(activity.unit, activity)

    assert_selector "#activity-edit-link"
    assert_selector "#copy-activity-link"
    assert_selector "#archive-button"
    assert_selector "#destroy-button"

    assert_text activity.duration_days + ' day'
    click_on "activity-edit-link"
    fill_in "Number of days", with: '5'
    fill_in "What's a good title for your activity idea?", with: activity.name + 'New'
    click_on "Update Activity"
    assert_text "Activity was successfully updated."
    assert_selector "h1", text: activity.reload.name
    assert_text "5 days"
  end

  test "editing an activity (as owner)" do
    activity = create(:activity)
    admin = create(:owner_user, unit: activity.unit)
    sign_in(admin)
    visit unit_activity_url(activity.unit, activity)

    assert_selector "#activity-edit-link"
    assert_selector "#copy-activity-link"
    assert_selector "#archive-button"
    assert_selector "#destroy-button"

    assert_text activity.duration_days + ' day'
    click_on "activity-edit-link"
    fill_in "Number of days", with: '10'
    fill_in "What's a good title for your activity idea?", with: activity.name + 'NewAgain'
    click_on "Update Activity"
    assert_text "Activity was successfully updated."
    assert_selector "h1", text: activity.reload.name
    assert_text "10 days"
  end

  test "creating an activity out of a users unit" do
    unit = create(:unit)
    sign_in
    visit unit_activities_path(unit)
    assert_no_link "Vote"
    assert_no_link "Propose an Activity"

    visit new_unit_activity_path(unit)
    assert_selector "h1", text: 'Planning Scout Activities'
  end

  test "creating an activity within a users unit" do
    sign_in
    assert_text "No activities have been proposed."
    within "#activities" do
      click_on "Propose an Activity"
    end

    assert_selector "h1", text: "What's your Activity idea?"

    fill_in "What's a good title for your activity idea?", with: Faker::Lorem.sentence(word_count: 5)
    fill_in "A brief 2-3 lines summarizing your idea", with: Faker::Lorem.sentence(word_count: 3) 
    fill_in "Number of days", with: "3"
    check "Swimming"
    check "Biking"
    check "Hiking"
    check "Flying"
    click_on "Create Activity"
    assert_text "Activity was successfully created."
  end

  test "creating an activity with all icons" do
    sign_in
    visit new_unit_activity_path(@user.unit)
    fill_in "What's a good title for your activity idea?", with: Faker::Lorem.sentence(word_count: 5)
    fill_in "A brief 2-3 lines summarizing your idea", with: Faker::Lorem.sentence(word_count: 3) 

    check "Hiking"
    check "Camping"
    check "Swimming"
    check "Flying"
    check "Community service"
    check "Biking"
    check "Cooking"
    check "Merit badge"
    check "Fundraising"
    check "International Scouting"
    check "Virtual"
    check "Game"
    check "High Adventure"
    click_on "Create Activity"
    assert_text "Activity was successfully created."

    assert_selector "#hiking-icon"
    assert_selector "#camping-icon"
    assert_selector "#swimming-icon"
    assert_selector "#biking-icon"
    assert_selector "#flying-icon"
    assert_selector "#cooking-icon"
    assert_selector "#merit-badge-icon"
    assert_selector "#fundraising-icon"
    assert_selector "#game-icon"
    assert_selector "#virtual-icon"
    assert_selector "#community-service-icon"
    assert_selector "#international-icon"
    assert_selector "#high-adventure-icon"
  end

  test "archiving/unarchiving an activity" do
    sign_in
    activity = create(:activity, author: @user)

    user = create(:user, unit: @user.unit)
    create_list(:vote, 6, user: user, activity: activity)

    assert_equal 1, activity.unit.activities.votable.count
    assert_equal 0, activity.unit.activities.archived.count

    visit unit_activity_path(activity.unit, activity)
    assert_selector "#activity-vote-count", text: '6'

    assert_equal 1, activity.unit.activities.votable.count
    assert_equal 0, activity.unit.activities.archived.count
    assert_equal 6, activity.votes.count

    click_button 'Archive'
    assert_selector "#flash", text: 'Activity is archived, and no longer in the activity voting list.'

    assert_selector "#unarchive-button"
    assert_no_selector "#archive-button"

    assert_selector "#activity-vote-count", text: '0'

    click_on 'Vote'
    assert_selector "h2", text: "Archived"

    visit unit_activity_path(@user.unit, activity)
    click_button "Unarchive"

    assert_equal 1, activity.reload.unit.activities.votable.count
    assert_equal 0, activity.unit.activities.archived.count
    assert_equal 0, activity.votes.count
  end
  
  test "voting on an activity" do
    # votes are handled in votes_test.rb
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
    assert_equal 0, user.unit.activities.count
    click_on "brand-logo"
    click_on activity.unit.name
    click_on activity.name
    click_on "copy-activity-link"
    assert_equal 1, user.unit.activities.count
    assert_text "'#{activity.name}' copied to your Unit."
  end

  test "admnin user viewing activities" do
    user = create(:admin_user)
    activities = create_list(:activity, 3, unit: user.unit, author: user)
    sign_in(user)
    visit unit_activity_path(user.unit, activities[1])

    assert_selector "#activity-edit-link"
    assert_selector "#copy-activity-link"
    assert_selector "#archive-button"
    assert_selector "#destroy-button"
  end
end
