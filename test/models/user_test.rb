require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "creating a user" do
    assert create(:user)
  end

  test "creating an author" do
    assert create(:author)
  end
end
