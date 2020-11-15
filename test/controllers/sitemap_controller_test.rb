require 'test_helper'

class SitemapControllerTest < ActionDispatch::IntegrationTest
  test "should get sitemap" do
    unit = create(:activity).unit
    example_unit = create(:example_unit)
    create_list(:activity, 10, unit: unit)
    create_list(:troop_activity, 10, unit: example_unit)
    get '/sitemap.xml'
    assert_response :success
  end
end
