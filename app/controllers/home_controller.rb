class HomeController < ApplicationController
  def index
    @troops = Troop.all
  end

  def about
    @title = 'About - ScoutActivity'
  end

  def resources
    @title = 'Activity Resources - ScoutActivity'
  end
end
