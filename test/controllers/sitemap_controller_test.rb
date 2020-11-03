require 'test_helper'

class SitemapControllerTest < ActionDispatch::IntegrationTest
  test "should get sitemap" do
    unit = create(:activity).unit
    create_list(:activity, 10, unit: unit)
    get '/sitemap.xml'
    assert_response :success
  end
end
