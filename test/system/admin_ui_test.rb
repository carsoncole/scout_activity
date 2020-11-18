require 'application_system_test_case'

class AdminUiTest < ApplicationSystemTestCase
  test 'admin viewing unit' do
    owner_user = create(:owner_user)

    sign_in(owner_user)
    click_on 'navbarDropdown'
    within '#user-menu' do
      click_on owner_user.unit.name
    end

    # check that all major components exist
    assert_selector 'h1', text: owner_user.unit.name
    assert_selector 'h2', text: 'Users'
    assert_text 'Share the following link'
    has_link? sign_up_url(unit_id: owner_user.unit.id)
    has_table? 'users'

    # check users and votes cast tally
    user = create(:user, unit: owner_user.unit)
    visit edit_unit_path(owner_user.unit)
    assert_selector 'table#users tr', count: 3
    assert_selector 'table#users tr td', text: '0', count: 2

    activity = create(:activity, author: user, unit: user.unit)
    create_list(:vote, 7, activity: activity, user: user)
    visit edit_unit_path(owner_user.unit)
    assert_selector 'table#users tr td', text: '7', count: 1
    save_screenshot('tmp/screenshots/votes_cast.png')
  end
end
