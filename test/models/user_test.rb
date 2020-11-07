require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "creating a user" do
    assert create(:user)
  end

  test "creating a user without a unit" do
    create(:user, unit: nil)
 end

  test "creating an author" do
    assert create(:author)
  end

  test "destroying a user, their votes, but not their activites," do
    user = create(:user)
    unit = user.unit
    activities = create_list(:activity, 5, author: user)
    activities[0].votes.create(user: user)
    activities[1].votes.create(user: user)
    assert_equal 2, user.votes_count
    assert_equal 1, activities[0].votes_count
    assert_equal 2, unit.votes_cast
    assert_equal 2, Vote.all.size
    assert_equal 5, unit.activities.count
    assert_equal 1, unit.users.count
    assert_equal 2, unit.users.first.votes.count
    user.reload.destroy
    assert_equal 0, unit.users.count # unit users reduced
    assert_equal 0, Vote.all.size # destroyed user's votes removed
    assert_equal 0, unit.reload.votes_cast # unit votes reduced by same amount
    assert_equal 5, unit.activities.count # unit activities unchanged
  end
end
