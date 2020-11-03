#TODO Add emailing for password resets
class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :set_unit

  def set_unit
    @unit = Unit.friendly.find(params[:unit_id]) if params[:unit_id]
  end
end
