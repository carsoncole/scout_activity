require 'application_system_test_case'

class PublicPagesTest < ApplicationSystemTestCase
  test 'visiting root' do
    visit root_url
    assert_selector 'img', id: 'root-page-logo'

    within('#main-nav') do
      click_on 'Sign in'
    end

    assert_selector 'h1', text: 'Sign in'

    within('#main-nav') do
      click_on 'Sign up'
    end

    assert_selector 'h1', text: 'Sign up'
  end

  test 'ideas for troop activities' do
    create_list(:troop_activity, 5, unit: create(:example_unit))
    visit '/'
    within'#main-nav' do
      click_on "#{Unit.example.first.activities.troop.count} Ideas for Troop Activities"
    end
    assert_selector 'h1', text: "#{Unit.example.first.activities.troop.count} Ideas for Troop Activities"
    assert_selector 'article', count: 5
    visit '/'
    within'footer' do
      click_on "#{Unit.example.first.activities.troop.count} Ideas for Troop Activities"
    end
  end

  test 'ideas for troop covid safe activities' do
    create_list(:troop_covid_safe_activity, 5, unit: create(:example_unit))
    visit '/'
    within'#main-nav' do
      click_on "#{Unit.example.first.activities.troop.covid_safe.count} Ideas for COVID Safe Troop Activities"
    end
    assert_selector 'h1', text: "#{Unit.example.first.activities.troop.covid_safe.count} Ideas for COVID Safe Troop Activities"
    assert_selector 'article', count: 5
    visit '/'
    within'footer' do
      click_on "#{Unit.example.first.activities.troop.covid_safe.count} Ideas for COVID Safe Troop Activities"
    end
  end

  test 'visiting about' do
    visit '/'
    click_on 'About'
    assert_selector 'h1', text: 'About'
    assert_text 'Questions or feedback?'
  end

  test 'visiting FAQs' do
    visit '/'
    click_on 'FAQs'
    assert_selector 'h1', text: 'FAQs'
  end

  test 'visiting Resources' do
    visit '/'
    click_on 'Resources'
    assert_selector 'h1', text: 'Activity Resources'
  end

  test 'visiting ideas for troop activities' do
    example_unit = create(:example_unit)
    create_list(:troop_activity, 10, unit: example_unit)
    count = example_unit.reload.troop_count
    title = "#{count} Ideas for Troop Activities"
    visit '/'
    click_on "#{count} Ideas for Troop Activities"
    assert_selector 'h1', text: title
  end

  test 'main nav logo' do
    visit root_url
    click_on 'brand-logo'
    assert_text 'Scouting leader Unit tool for finding and promoting new activity ideas.'
  end

  test 'visiting sitemap' do
    visit '/sitemap.xml'
  end

  test 'forgetting password' do
    visit sign_in_url
    click_on 'Forgot password?'
    assert_selector 'h1', text: 'Reset your password'
    fill_in 'Email address', with: Faker::Internet.email
    click_on 'Reset password'
  end

  test 'Adding a Troop without signed in' do
    visit root_url
    click_on 'Get started'
  end
end
