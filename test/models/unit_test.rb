require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  test 'creating a unit' do
    assert create(:unit)
  end
end
