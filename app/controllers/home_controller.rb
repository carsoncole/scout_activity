class HomeController < ApplicationController
  def index
    @troops = Troop.all
  end

  def info
    @title = 'Info - ScoutActivity'
  end
end
