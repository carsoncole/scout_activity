require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "signing up, creating a unit" do
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
    click_on "create a unit"
    assert_selector "h1", text: "Add your Unit"
    name = "Unit 100 Anytown"
    fill_in "Unit number and city", with: name
    click_on "Create Unit"
    assert_text "Unit was successfully created."
    assert_selector "h1", text: name + " Activity Vote"
    assert_text "No activities have been proposed."

    click_on "navbarDropdown"
    within "#user-menu" do
      click_on name
    end

    assert_selector "h1", text: name
    fill_in "Unit number and city", with: name + ", USA"
    click_on "Update Unit"
    assert_text "Unit was successfully updated."
  end

  test "signing up, and using an existing unit" do
    unit = create(:unit)
    visit sign_up_url
    within "#clearance.sign-up" do
      fill_in "Email", with: Faker::Internet.email
      fill_in "Password", with: "password"
      all('#unit-select option')[1].select_option
      click_on "Sign up"
    end
    assert_equal unit, User.last.unit
  end

  test "visiting profile" do
    user = create(:user)
    visit sign_in_url
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    within "#clearance.sign-in" do
      click_on "Sign in"
    end
    click_on "navbarDropdown"
    within "#user-menu" do
      click_on user.email
    end
  end
end
