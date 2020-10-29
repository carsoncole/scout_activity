class SitemapController < ApplicationController
  def sitemap
    @troops = Troop.all
    @activities = Activity.votable
  end
end
