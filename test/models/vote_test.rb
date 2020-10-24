require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "creating a vote" do
    assert create(:vote)
  end

  test "user creating many votes for 1 activity not exceeding max allowed" do
    user = create(:user)
    troop = user.troop
    author = create(:user, troop: troop)
    activity = create(:activity, troop: troop, author: author)

    assert create_list(:vote, troop.votes_allowed, activity: activity, user: user)
    vote = build(:vote, user: user, activity: activity)
    assert_not vote.valid?
  end
end
