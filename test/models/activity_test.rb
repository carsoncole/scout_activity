require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  test 'creating an activity' do
    assert create(:activity)
  end

  test 'archiving an activity and returning votes' do
    activity = create(:activity)
    create_list(:unit_vote, 10, user: activity.author, activity: activity)
    assert_equal 10, activity.unit_votes.count
    assert_equal 10, activity.author.unit_votes_count
    activity.update(is_archived: true)
    assert_equal 0, activity.unit_votes_count
  end

  test 'clearing votes' do
    activity = create(:activity)
    create_list(:unit_vote, 10, user: activity.author, activity: activity)
    assert_equal 10, activity.author.unit_votes_count
    activity.author.reload.clear_unit_votes!
    assert_equal 0, activity.author.unit_votes_count
  end
end
