require "application_system_test_case"

class UnitsTest < ApplicationSystemTestCase
  test "visiting the unit edit as a user" do
    user = create(:user)
    sign_in(user)
    visit edit_unit_url(user.unit)
    assert_selector "h1", text: 'Planning Scout Activities' # redirect to root
  end

  test "visiting unit as owner" do
    owner = create(:owner_user)
    sign_in(owner)
    visit edit_unit_url(owner.unit)
    assert_selector "h1", text: owner.unit.name
    assert_table "users"
  end

  test "visiting unit as admin" do
    admin = create(:admin_user)
    sign_in(admin)
    visit edit_unit_url(admin.unit)
    assert_selector "h1", text: admin.unit.name
    assert_table "users"
  end

  test "destroying unit but keeping users" do
    owner = create(:owner_user)
    sign_in(owner)

    click_on "navbarDropdown"
    within "#user-menu" do
      has_link? @user.unit.name
    end
    owner.unit.destroy
    visit root_url
    click_on "navbarDropdown"
    within "#user-menu" do
      has_no_link? @user.unit.name
    end
    assert_nil owner.reload.unit_id
  end

  test "deleting a user from a unit and returning their votes" do
    owner = create(:owner_user)
    user = create(:user, unit: owner.unit)
    activity = create(:activity, unit: user.unit)
    create_list(:vote, 10, activity: activity, user:user)
    assert_equal 10, activity.votes.count
    sign_in(owner)
    visit edit_unit_url(owner.unit)
    assert_selector "h1", text: owner.unit.name
    assert_table "users"
    # page.execute_script "window.scrollTo(800,800)"
    within "#users" do
      assert_selector "tr", count: 3
      assert_selector "#user-#{user.id}-remove-link"
      accept_confirm do
        click_on "user-#{user.id}-remove-link"
      end
    end
    assert_selector "tr", count: 2
    assert user.reload
    assert_nil user.unit_id

    assert_equal 0, activity.reload.votes.count
  end

  test "updating a Unit" do
    owner = create(:owner_user)
    sign_in(owner)

    click_on "navbarDropdown"
    within "#user-menu" do
      click_on owner.unit.name
    end

    fill_in "Unit number and city", with: ''
    click_on "Update Unit"

    assert_text "1 error prohibited this unit from being saved"
  end

  test "creating a Unit" do
    user = create(:user, unit: nil)
    sign_in(user)

    click_on "Add your Unit"
    fill_in "Unit number and city", with: ''
    click_on "Create Unit"

    assert_text "error prohibited this unit from being saved"
  end
end
