require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test 'user creating many votes for 1 activity not exceeding max allowed' do
    activity = create(:activity)
    create_list(:vote, activity.unit.votes_allowed, user: activity.author, activity: activity)
    vote = activity.votes.build(user: activity.author)
    assert_not vote.valid?
  end

  test 'creating invalid votes' do
    vote = build(:vote, user: nil)
    assert_not vote.valid?

    vote = build(:vote, activity: nil)
    assert_not vote.valid?
  end

  test 'increasing unit vote counts' do
    user = create(:user)
    unit = user.unit
    activity = create(:activity, unit: unit, author: user)
    assert_equal 20, user.votes_available
    create_list(:vote, 20, user: user, activity: activity)
    assert_equal 20, activity.votes.count

    assert_equal 0, user.reload.votes_available

    unit.update(votes_allowed: 30)
    assert_equal 10, user.reload.votes_available
    assert_equal 20, activity.votes.count
  end

  test 'decreasing unit vote counts' do
    user = create(:user)
    unit = user.unit
    activity = create(:activity, unit: unit, author: user)
    assert_equal 20, user.votes_available
    create_list(:vote, 20, user: user, activity: activity)
    assert_equal 20, activity.votes.count
    assert_equal 20, user.votes_cast

    unit.update(votes_allowed: 10)
    assert_equal 0, user.reload.votes_available
    assert_equal 10, user.votes_cast
    assert_equal 10, activity.votes.count
  end
end
