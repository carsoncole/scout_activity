require 'test_helper'

class SitemapControllerTest < ActionDispatch::IntegrationTest
  test "should get sitemap" do
    troop = create(:activity).troop
    create_list(:activity, 10, troop: troop)
    get '/sitemap.xml'
    assert_response :success
  end
end
