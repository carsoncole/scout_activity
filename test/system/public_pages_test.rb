require "application_system_test_case"

class PublicPagesTest < ApplicationSystemTestCase

  test "visiting root" do
    visit root_url
    assert_selector "img", id: 'root-page-logo'
    assert_text "Tracking ideas for Scout activities."

    within("#main-nav") do
      click_on "Sign in"
    end

    assert_selector "h1", text: 'Sign in'

    within("#main-nav") do
      click_on "Sign up"
    end

    assert_selector "h1", text: 'Sign up'
  end

  test "visiting info" do
    visit '/'
    click_on "About"
    assert_selector "h1", text: 'About'
    assert_text "Questions or feedback?"
  end

  test "main nav logo" do
    visit root_url
    click_on "brand-logo"
    assert_text "Tracking ideas for Scout activities."
  end

  test "forgetting password" do
    visit sign_in_url
    click_on "Forgot password?"
    assert_selector "h1", text: "Reset your password"
    fill_in "Email address", with: Faker::Internet.email
    click_on "Reset password"
  end

  test "Adding a Troop without signed in" do
    visit root_url
    click_on "Add your Troop"
  end

end
