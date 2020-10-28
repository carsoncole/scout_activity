require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "signing up, creating a troop" do
    visit root_url
    within "#main-nav" do
      click_on "Sign up"
    end
    within "#clearance.sign-up" do
      assert_selector "h1", text: "Sign up"
      fill_in "Email", with: Faker::Internet.email
      fill_in "Password", with: "password"
      
      click_on "Sign up"
    end
    assert_selector "h2", text: "You're signed up."
    assert_text "The next step is to"
    click_on "create a troop"
    assert_selector "h1", text: "Add your Troop"
    unit_name = "Troop 100 Anytown"
    fill_in "Troop Unit number and city", with: unit_name
    click_on "Create Troop"
    assert_text "Troop was successfully created."
    click_on unit_name
    assert_selector "h1", text: "Vote for Activities"
    assert_text "No activities have been proposed."

    click_on "navbarDropdown"
    within "#user-menu" do
      click_on unit_name
    end

    assert_selector "h1", text: "Edit Troop"
    fill_in "Troop Unit number and city", with: unit_name + ", USA"
    click_on "Update Troop"
    assert_text "Troop was successfully updated."
  end


end
