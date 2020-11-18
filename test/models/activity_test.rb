require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  test 'creating an activity' do
    assert create(:activity)
  end

  test 'archiving an activity and returning votes' do
    activity = create(:activity)
    create_list(:vote, 10, user: activity.author, activity: activity)
    assert_equal 10, activity.votes.count
    assert_equal 10, activity.author.votes_cast
    activity.update(is_archived: true)
    assert_equal 0, activity.author.votes_cast
    assert_equal 0, activity.votes.count
  end

  test 'clearing votes' do
    activity = create(:activity)
    create_list(:vote, 10, user: activity.author, activity: activity)
    assert_equal 10, activity.author.votes_cast
    activity.author.reload.clear_votes!
    assert_equal 0, activity.author.votes_count
  end
end
