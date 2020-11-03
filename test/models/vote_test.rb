require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "creating a vote" do
    assert create(:vote)
  end

  test "user creating many votes for 1 activity not exceeding max allowed" do
    user = create(:user)
    unit = user.unit
    author = create(:user, unit: unit)
    activity = create(:activity, unit: unit, author: author)

    assert create_list(:vote, unit.votes_allowed, activity: activity, user: user)
    vote = build(:vote, user: user, activity: activity)
    assert_not vote.valid?
  end
end
