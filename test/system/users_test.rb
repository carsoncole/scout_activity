require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "signing up, creating a unit" do
    visit root_url
    within "#main-nav" do
      click_on "Sign up"
    end
    assert_selector "h1", text: "Sign up"
    within "#clearance.sign-up" do
      fill_in "Email", with: Faker::Internet.email
      fill_in "Password", with: "password"

      assert_no_selector "user_is_admin"
      assert_no_selector "user_is_owner"
      assert_no_selector "user_is_subscribed"

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

  test "unsubscribing and subscribing a user" do
    user = create(:user)
    assert user.is_subscribed
    visit user_unsubscribe_path(user)
    sign_in(user)
    click_on "navbarDropdown"
    within "#user-menu" do
      click_on user.email
    end
    assert_not find("#user_is_subscribed").checked?

    check "user_is_subscribed"
    click_on "Update"

    click_on "navbarDropdown"
    within "#user-menu" do
      click_on user.email
    end
    assert find("#user_is_subscribed").checked?
  end

  test "editing a user" do
    user = create(:user)
    sign_in(user)
    click_on "navbarDropdown"
    within "#user-menu" do
      click_on user.email
    end

    assert_no_selector "#user_is_admin"
    assert_no_selector "#user_is_owner"
    assert_selector "#user_is_subscribed"

    fill_in "Email", with: "new_email@example.com"
    click_on "Update"
    assert_text "Your account has been updated"
    # click_on "navbarDropdown"
    # has_link? "new_email@example.com"
  end

  test "editing an admin" do
    user = create(:admin_user)
    sign_in(user)
    click_on "navbarDropdown"
    within "#user-menu" do
      click_on user.email
    end

    assert_selector "#user_is_admin"
    assert_no_selector "#user_is_owner"
    assert_selector "#user_is_subscribed"
  end

  test "editing an owner" do
    user = create(:owner_user)
    sign_in(user)
    click_on "navbarDropdown"
    within "#user-menu" do
      click_on user.email
    end

    assert_no_selector "#user_is_admin"
    assert_selector "#user_is_owner"
    assert_selector "#user_is_subscribed"
  end

  test "editing a user unit" do
    user = create(:user)
    sign_in(user)
    click_on "navbarDropdown"
    within "#user-menu" do
      assert_no_link user.unit.name
    end
  end

  test "editing a admin unit" do
    user = create(:admin_user)
    sign_in(user)
    click_on "navbarDropdown"
    within "#user-menu" do
      assert_link user.unit.name
      click_on user.unit.name
    end
    assert_selector "h1", text: user.unit.name
    has_table? "#users"
  end

  test "editing a owner unit" do
    user = create(:owner_user)
    user_2 = create(:user, unit: user.unit)
    sign_in(user)
    click_on "navbarDropdown"
    within "#user-menu" do
      assert_link user.unit.name
      click_on user.unit.name
    end
    assert_selector "h1", text: user.unit.name
    has_table? "#users"

    click_on "user-#{user.id}-edit-link"
    assert_no_selector "#user_is_admin"
    find_field "user[is_owner]", disabled: true
    assert_selector "#user_is_subscribed"

    click_on "navbarDropdown"
    within "#user-menu" do
      assert_link user.unit.name
      click_on user.unit.name
    end
    click_on "user-#{user_2.id}-edit-link"
    assert_no_selector "#user_is_admin"
    assert_no_selector "#user_is_owner"
    assert_selector "#user_is_subscribed"
  end
end
