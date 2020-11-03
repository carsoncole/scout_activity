require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  test "creating a unit" do
    assert unit = create(:unit)
  end
end
