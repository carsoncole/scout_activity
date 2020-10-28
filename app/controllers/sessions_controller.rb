class SessionsController < Clearance::SessionsController

  def new
    @title = "Sign in - ScoutActivity"
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