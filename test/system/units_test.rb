require "application_system_test_case"

class UnitsTest < ApplicationSystemTestCase
  test "viewing unit page" do
    admin = create(:user, is_owner: true)
    sign_in(admin)
    click_on "navbarDropdown"
    within "#user-menu" do
      click_on admin.unit.name
    end
    assert_selector "h1", text: 'Edit Unit'
    assert_selector "h2", text: 'Users'
  end

  # test "visiting the index" do
  #   visit units_url
  #   assert_selector "h1", text: "Troops"
  # end

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
