require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  test "creating an activity" do
    assert create(:activity)
  end
end
