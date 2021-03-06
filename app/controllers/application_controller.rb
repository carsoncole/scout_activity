# TODO: Add emailing for password resets
class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :set_unit

  def set_unit
    if params[:unit_id]
      @unit = Unit.friendly.find(params[:unit_id]) if params[:unit_id]
    elsif
      controller_name == 'units'
      @unit = Unit.friendly.find(params[:id]) if params[:id]
    end
  end

  def sign_in(user)
    # store current time to display "last signed in at" message
    user&.update(last_sign_in_at: Time.now, sign_in_count: user.sign_in_count + 1)
    super user
  end

  def require_admin_owner_login
    redirect_to root_path unless @unit && signed_in? && current_user.unit == @unit && current_user.admin_or_owner?
  end
end
