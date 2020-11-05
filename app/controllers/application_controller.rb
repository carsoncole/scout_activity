#TODO Add emailing for password resets
class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :set_unit

  def set_unit
    @unit = Unit.friendly.find(params[:unit_id]) if params[:unit_id]
  end

  def sign_in(user)
    # store current time to display "last signed in at" message
    user.update(last_sign_in_at: Time.now, sign_in_count: user.sign_in_count + 1) if user
    super user
  end
end
