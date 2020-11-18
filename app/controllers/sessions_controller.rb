class SessionsController < Clearance::SessionsController
  def new
    @title = 'Sign in - ScoutActivity'
    super
  end

  def create
    cookies[:debug] = { value: true, expires: 1.year } if params[:session][:email] == 'carson.cole@protonmail.com'
    super
  end

  def url_after_create
    if current_user.unit && current_user.admin_or_owner?
      unit_activities_path(current_user.unit, logged_in: 'success', admin: true)
    elsif current_user.unit
      unit_activities_path(current_user.unit, logged_in: 'success')
    else
      root_url(logged_in: 'success')
    end
  end
end
