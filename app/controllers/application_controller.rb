class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :set_troop

  def set_troop
    @troop = Troop.find_by(id: params[:troop_id]) if params[:troop_id]
  end
end
