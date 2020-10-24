require 'test_helper'

class TroopTest < ActiveSupport::TestCase
  test "creating a troop" do
    assert create(:troop)
  end
end
