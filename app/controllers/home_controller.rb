class HomeController < ApplicationController
  def index
    @troops = Troop.all
  end

  def about
    @title = 'Info - ScoutActivity'
  end
end
