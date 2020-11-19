class SitemapController < ApplicationController
  def sitemap
    @sitemap = Sitemap.new
  end
end
