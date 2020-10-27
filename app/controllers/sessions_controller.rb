class SessionsController < Clearance::SessionsController

  def url_after_create
    if current_user.troop
      troop_activities_path(current_user.troop)
    else
      super
    end
  end
end