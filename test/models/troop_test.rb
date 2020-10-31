require 'test_helper'

class TroopTest < ActiveSupport::TestCase
  test "creating a troop" do
    assert troop = create(:troop)
  end
end
