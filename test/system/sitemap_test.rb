require 'application_system_test_case'

class SitemapTest < ApplicationSystemTestCase
  def setup
    unit = create(:example_unit)
    create_list(:activity, 5, unit: unit)
    create_list(:fundraising_activity, 3, unit: unit)
    create_list(:troop_covid_safe_activity, 4, unit: unit)
  end

  test "viewing sitemap" do
    visit '/sitemap.xml'
  end

  test "viewing sitemap with covid safe activities" do
    visit '/sitemap.xml'
    assert_equal "/covid-safe-troop-activity-ideas", covid_safe_troop_activity_ideas_path
  end

  test "viewing sitemap with fundraising activities" do
    visit '/sitemap.xml'
    assert_equal "/fundraising-activity-ideas", fundraising_activity_ideas_path
  end

  test "viewing sitemap with troop activities" do
    visit '/sitemap.xml'
    assert_equal "/troop-activity-ideas", troop_activity_ideas_path
  end
end
