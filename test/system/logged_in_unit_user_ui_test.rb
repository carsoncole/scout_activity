require "application_system_test_case"

class LoggedInUnitUserUiTest < ApplicationSystemTestCase
  test "clicking all ui elements" do
    user = create(:user, is_owner: true)
    sign_in(user)
    
    # brand logo link
    click_on "brand-logo"
    
    
    # unit button-home page
    click_on user.unit.name
    assert_selector "h1", text: user.unit.name + " Activity Vote"

    # main nav vote links
    click_on "vote-link"
    assert_selector "h1", text: user.unit.name + " Activity Vote"

    # main nav propose link
    click_on "propose-link"
    assert_selector "h1", text: "What's your Activity idea?"

    # main nav dropdown user email
    click_on "navbarDropdown"
    within "#user-menu" do
      click_on user.email
    end
    assert_selector "h1", text: user.email

    # main nav dropdown sign out
    click_on "navbarDropdown"
    within "#user-menu" do
      click_on "Sign out"
    end
    assert_selector "h1", text: "Sign in"
  end
end