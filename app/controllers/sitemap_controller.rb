class SitemapController < ApplicationController
  def sitemap
    @troops = Troop.all
    @activities = Activity.votable
    @last_root_page_update = File.new("app/views/home/about.html.haml").ctime.strftime("%Y-%m-%d")
    time = File.new("app/views/home/index.html.haml").ctime.strftime("%Y-%m-%d")
    @last_root_page_update = time if time > @last_root_page_update
    time = Troop.order(updated_at: :desc).first.updated_at.strftime("%Y-%m-%d")
    @last_root_page_update = time if time > @last_root_page_update
  end
end
