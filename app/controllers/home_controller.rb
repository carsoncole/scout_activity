class HomeController < ApplicationController
  def index
    @units = Unit.order(visit_event_count: :desc)
  end

  def about
    @title = 'About - ScoutActivity'
    @description = 'Scout Units need a constant source of good ideas for activities. Scout Activity can help in sourcing ideas from Scouts, parents, and the wider community and then allow for Scouts to vote on their favorites.'
  end

  def resources
    @title = 'Activity Resources - ScoutActivity'
    @description = 'A list of currated resources for sourcing Scout activities.'
  end

  def faqs
    @title = 'FAQs - ScoutActivity'
    @description = 'Frequently asked questions about how to best use ScoutActivity.com'
  end

  def example_units
    @example_units = Unit.example
    @title = 'Example units - ScoutActivity'
    @description = 'Here are Unit examples that you can view and copy the activities'
  end
end
