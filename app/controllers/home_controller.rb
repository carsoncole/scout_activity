class HomeController < ApplicationController
  def index
    @troops = Troop.order(visit_event_count: :desc)
  end

  def about
    @title = 'About - ScoutActivity'
  end

  def resources
    @title = 'Activity Resources - ScoutActivity'
  end
end
