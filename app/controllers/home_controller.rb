class HomeController < ApplicationController
  def index
    @units = Unit.non_example.order(visit_event_count: :desc)
    @example_unit = Unit.example.first
    return unless signed_in? && current_user.unit.nil?

    flash[:alert] = "To vote, select a Unit in your <a href='/users/#{current_user.id}/edit'>Profile</a> settings."
  end

  def about
    @title = 'About - Scout Activity'
    @description = 'Scout Units need a constant source of good ideas for activities. Scout Activity can help in sourcing ideas from Scouts, parents, and the wider community and then allow for Scouts to vote on their favorites.'
  end

  def resources
    @title = 'Helpful Scout activity resources - Scout Activity'
    @description = 'A list of curated resources for sourcing Scout activities.'
  end

  def faqs
    @title = 'Frequently asked questions - Scout Activity'
    @description = 'Frequently asked questions about how to best use ScoutActivity.com'
  end
end
