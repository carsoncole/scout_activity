class HomeController < ApplicationController
  def index
    @troops = Troop.all
  end

  def info
    @title = 'ScoutActivity | Info'
  end
end
