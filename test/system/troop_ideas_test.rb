require 'application_system_test_case'

class TroopIdeasTest < ApplicationSystemTestCase
  def setup
    @example_unit = create(:example_unit)
    @activities = create_list(:troop_activity, 10, unit: @example_unit)
    @count = @example_unit.troop_count
    @activities_title = "#{@count} Ideas for Troop Activities"
  end

  test 'visiting as public, ideas for troop activities' do
    visit '/'
    click_on @activities_title
    assert_selector 'h1', text: @activities_title
    assert_selector '#activities', count: 1
    within '#activities' do
      assert_selector 'article', count: @count
      assert_no_selector "#copy-activity-#{@activities[0].id}-link"
    end

    click_on @activities[1].name
    assert_no_selector '#activity-vote-count'

    assert_no_selector '#activity-edit-link'
    assert_no_selector '#copy-activity-link'
    assert_no_selector '#archive-button'
    assert_no_selector '#destroy-button'
  end

  test 'visiting as user, ideas for troop activities' do
    sign_in
    within '#main-nav' do
      click_on "#{@count} Ideas for Troop Activities"
    end
    assert_selector 'h1', text: @activities_title
    assert_selector '#activities', count: 1
    within '#activities' do
      assert_selector 'article', count: @count
      assert_no_selector "#copy-activity-#{@activities[0].id}-link"
    end
    click_on @activities[1].name
    assert_no_selector '#activity-vote-count'

    assert_no_selector '#activity-edit-link'
    assert_no_selector '#copy-activity-link'
    assert_no_selector '#archive-button'
    assert_no_selector '#destroy-button'
  end

  test 'visiting as a unit owner, ideas for troop activities' do
    owner = create(:owner_user)
    sign_in(owner)
    click_on @activities_title
    assert_selector 'h1', text: @activities_title
    assert_selector '#activities', count: 1
    within '#activities' do
      assert_selector 'article', count: @count
      assert_selector "#copy-activity-#{@activities[0].id}-link"
    end
    click_on @activities[1].name
    assert_no_selector '#activity-vote-count'

    assert_no_selector '#activity-edit-link'
    assert_selector '#copy-activity-link'
    assert_no_selector '#archive-button'
    assert_no_selector '#destroy-button'
  end

  test 'visiting as a unit admin, ideas for troop activities' do
    owner = create(:owner_user)
    sign_in(owner)
    click_on @activities_title
    assert_selector 'h1', text: @activities_title
    assert_selector '#activities', count: 1
    within '#activities' do
      assert_selector 'article', count: @count
      assert_selector "#copy-activity-#{@activities[0].id}-link"
    end
    click_on @activities[1].name
    assert_no_selector '#activity-vote-count'

    assert_no_selector '#activity-edit-link'
    assert_selector '#copy-activity-link'
    assert_no_selector '#archive-button'
    assert_no_selector '#destroy-button'
  end

  test 'visiting as example unit owner, ideas for troop activities' do
    owner = create(:owner_user, unit: Unit.example.first)
    sign_in(owner)
    click_on @activities_title
    assert_selector 'h1', text: @activities_title
    assert_selector '#activities', count: 1
    within '#activities' do
      assert_selector 'article', count: @count
      assert_selector "#copy-activity-#{@activities[0].id}-link"
    end
    click_on @activities[1].name
    assert_no_selector '#activity-vote-count'

    assert_selector '#activity-edit-link'
    assert_selector '#copy-activity-link'
    assert_selector '#archive-button'
    assert_selector '#destroy-button'
  end

  test 'visiting as a unit owner, ideas for troop activities, and copying' do
    owner = create(:owner_user)
    sign_in(owner)
    click_on "#{@count} Ideas for Troop Activities"
    click_on "copy-activity-#{@activities[0].id}-link"
    assert_equal 1, owner.unit.activities.count
    assert_text "'#{@activities[0].name}' copied to your Unit."

    click_on @activities[1].name
    click_on 'copy-activity-link'
    assert_text "'#{@activities[1].name}' copied to your Unit."
  end

  test 'index and using filter' do
    @activities[0].update(is_hiking: true, is_camping: true)
    @activities[1].update(is_swimming: true, is_camping: true)
    @activities[2].update(is_merit_badge: true)
    @activities[3].update(is_plane: true, is_camping: true)
    @activities[4].update(is_swimming: true)
    @activities[5].update(is_game: true, is_virtual: true)
    @activities[6].update(is_community_service: true, is_camping: true)
    @activities[7].update(is_boating: true, is_camping: true)
    @activities[8].update(is_fundraising: true)
    @activities[9].update(is_hiking: true, is_camping: true)

    assert_equal 10, Unit.example.first.activities.troop.count

    visit root_url
    within 'footer' do
      click_on @activities_title
    end
    assert_selector '#activities'
    assert_selector 'article', count: 10

    click_on 'hiking-filter'
    assert_selector 'article', count: 2

    click_on 'flying-filter'
    assert_selector 'article', count: 1

    click_on 'swimming-filter'
    assert_selector 'article', count: 2

    click_on 'clear-filter'
    assert_selector 'article', count: 10
  end
end
