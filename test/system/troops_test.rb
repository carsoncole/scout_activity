require "application_system_test_case"

class TroopsTest < ApplicationSystemTestCase
  setup do
    @troop = troops(:one)
  end

  test "visiting the index" do
    visit troops_url
    assert_selector "h1", text: "Troops"
  end

  test "creating a Troop" do
    visit troops_url
    click_on "New Troop"

    fill_in "Unit number", with: @troop.unit_number
    click_on "Create Troop"

    assert_text "Troop was successfully created"
    click_on "Back"
  end

  test "updating a Troop" do
    visit troops_url
    click_on "Edit", match: :first

    fill_in "Unit number", with: @troop.unit_number
    click_on "Update Troop"

    assert_text "Troop was successfully updated"
    click_on "Back"
  end

  test "destroying a Troop" do
    visit troops_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Troop was successfully destroyed"
  end
end
