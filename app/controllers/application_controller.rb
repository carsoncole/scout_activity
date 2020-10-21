class ApplicationController < ActionController::Base
  before_action :set_troop
  before_action :set_user_id

  def set_troop
    @troop = Troop.find_by(params[:troop_id]) if params[:troop_id]
  end

  def set_user_id
    @user = if User.find_by(id: cookies[:user_id])
      User.find_by(id: cookies[:user_id])
    else
      cookies[:user_id] = SecureRandom.hex(10)
      User.create(cookie_id: cookies[:user_id])
    end
  end
end
