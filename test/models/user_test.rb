require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'creating a user' do
    assert create(:user)
  end

  test 'creating a user without a unit' do
    create(:user, unit: nil)
  end

  test 'creating an author' do
    assert create(:author)
  end

  test 'destroying a user, their votes, but not their activites,' do
    user = create(:user)
    unit = user.unit
    activities = create_list(:activity, 5, author: user)
    activities[0].unit_votes.create(user: user)
    activities[1].unit_votes.create(user: user)
    assert_equal 2, user.unit_votes_count
    assert_equal 1, activities[0].unit_votes_count
    assert_equal 2, unit.unit_votes_cast
    assert_equal 2, UnitVote.all.size
    assert_equal 5, unit.activities.count
    assert_equal 1, unit.users.count
    assert_equal 2, unit.users.first.unit_votes.count
    user.reload.destroy
    assert_equal 0, unit.users.count # unit users reduced
    assert_equal 0, UnitVote.all.size # destroyed user's votes removed
    assert_equal 0, unit.reload.unit_votes_cast # unit votes reduced by same amount
    assert_equal 5, unit.activities.count # unit activities unchanged
  end

  test 'name_email method' do
    user = create(:user)
    assert_equal user.email, user.name_email

    user.update(first_name: 'John')
    assert_equal "John (#{user.email})", user.name_email

    user.update(first_name: nil, last_name: 'Smith')
    assert_equal user.email, user.name_email

    user.update(first_name: 'John', last_name: 'Smith')
    assert_equal "John Smith (#{user.email})", user.name_email
  end
end
