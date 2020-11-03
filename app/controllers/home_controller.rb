class HomeController < ApplicationController
  def index
    @units = Unit.order(visit_event_count: :desc)
  end

  def about
    @title = 'About - ScoutActivity'
  end

  def resources
    @title = 'Activity Resources - ScoutActivity'
  end
end
