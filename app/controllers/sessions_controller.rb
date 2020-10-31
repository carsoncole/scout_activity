class SessionsController < Clearance::SessionsController

  def new
    @title = "Sign in - ScoutActivity"
    super
  end

  def create
    cookies[:debug] = {value: true, expires: 1.year} if params[:session][:email] == 'carson.cole@protonmail.com'
    super
  end


  def url_after_create
    if current_user.troop
      troop_activities_path(current_user.troop)
    else
      super
    end
  end
end