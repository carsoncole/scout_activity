require 'test_helper'

class VoteTest < ActiveSupport::TestCase

  test "user creating many votes for 1 activity not exceeding max allowed" do
    activity = create(:activity)
    create_list(:vote, activity.unit.votes_allowed, user: activity.author, activity: activity)
    vote = activity.votes.build(user: activity.author)
    assert_not vote.valid?
  end

  test "creating invalid votes" do
    vote = build(:vote, user: nil)
    assert_not vote.valid?

    vote = build(:vote, activity: nil)
    assert_not vote.valid?
  end
end
