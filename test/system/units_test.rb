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

  # test "creating a Troop" do
  #   visit units_url
  #   click_on "New Troop"

  #   fill_in "Unit number", with: @unit.unit_number
  #   click_on "Create Troop"

  #   assert_text "Troop was successfully created"
  #   click_on "Back"
  # end

  # test "updating a Troop" do
  #   visit units_url
  #   click_on "Edit", match: :first

  #   fill_in "Unit number", with: @unit.unit_number
  #   click_on "Update Troop"

  #   assert_text "Troop was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Troop" do
  #   visit units_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Troop was successfully destroyed"
  # end
end
