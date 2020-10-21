class HomeController < ApplicationController
  def index
    @troops = Troop.all
  end
end
