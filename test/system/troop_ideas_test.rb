require "application_system_test_case"

class TroopIdeasTest < ApplicationSystemTestCase
  def setup
    @example_unit = create(:example_unit)
    @activities = create_list(:troop_activity, 10, unit: @example_unit)
    @count = Activity.troop_ideas_count
    @title = "#{@count} Ideas for Troop Activities"
  end

  test "visiting as public, ideas for troop activities" do
    visit '/'
    click_on "#{@count} Ideas for Troop Activities"
    assert_selector "h1", text: @title
    assert_selector "#activities", count: 1
    assert_selector "li", count: @count
    assert_no_selector "#copy-activity-#{@activities[0].id}-link"

    click_on @activities[1].name
    assert_no_selector "#activity-vote-count"

    assert_no_selector "#activity-edit-link"
    assert_no_selector "#copy-activity-link"
    assert_no_selector "#archive-button"
    assert_no_selector "#destroy-button"
  end

  test "visiting as user, ideas for troop activities" do
    sign_in
    click_on "#{@count} Ideas for Troop Activities"
    assert_selector "h1", text: @title
    assert_selector "#activities", count: 1
    assert_selector "li", count: @count
    assert_no_selector "#copy-activity-#{@activities[0].id}-link"

    click_on @activities[1].name
    assert_no_selector "#activity-vote-count"

    assert_no_selector "#activity-edit-link"
    assert_no_selector "#copy-activity-link"
    assert_no_selector "#archive-button"
    assert_no_selector "#destroy-button"
  end

  test "visiting as a unit owner, ideas for troop activities" do
    owner = create(:owner_user)
    sign_in(owner)
    click_on "#{@count} Ideas for Troop Activities"
    assert_selector "h1", text: @title
    assert_selector "#activities", count: 1
    assert_selector "li", count: @count
    assert_selector "#copy-activity-#{@activities[0].id}-link"

    click_on @activities[1].name
    assert_no_selector "#activity-vote-count"

    assert_no_selector "#activity-edit-link"
    assert_selector "#copy-activity-link"
    assert_no_selector "#archive-button"
    assert_no_selector "#destroy-button"
  end

  test "visiting as a unit admin, ideas for troop activities" do
    owner = create(:owner_user)
    sign_in(owner)
    click_on "#{@count} Ideas for Troop Activities"
    assert_selector "h1", text: @title
    assert_selector "#activities", count: 1
    assert_selector "li", count: @count
    assert_selector "#copy-activity-#{@activities[0].id}-link"

    click_on @activities[1].name
    assert_no_selector "#activity-vote-count"

    assert_no_selector "#activity-edit-link"
    assert_selector "#copy-activity-link"
    assert_no_selector "#archive-button"
    assert_no_selector "#destroy-button"
  end

  test "visiting as example unit owner, ideas for troop activities" do
    owner = create(:owner_user, unit: Unit.example.first)
    sign_in(owner)
    click_on "#{@count} Ideas for Troop Activities"
    assert_selector "h1", text: @title
    assert_selector "#activities", count: 1
    assert_selector "li", count: @count
    assert_selector "#copy-activity-#{@activities[0].id}-link"

    click_on @activities[1].name
    assert_no_selector "#activity-vote-count"

    assert_selector "#activity-edit-link"
    assert_selector "#copy-activity-link"
    assert_selector "#archive-button"
    assert_selector "#destroy-button"
  end

  test "visiting as a unit owner, ideas for troop activities, and copying" do
    owner = create(:owner_user)
    sign_in(owner)
    click_on "#{@count} Ideas for Troop Activities"
    click_on "copy-activity-#{@activities[0].id}-link"
    assert_equal 1, owner.unit.activities.count
    assert_text "'#{@activities[0].name}' copied to your Unit."

    click_on @activities[1].name
    click_on "copy-activity-link"
    assert_text "'#{@activities[1].name}' copied to your Unit."
  end
end
