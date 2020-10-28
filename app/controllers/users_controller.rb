class UsersController < Clearance::UsersController
  before_action :set_title, only: [:edit]

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    new_params = user_params
    new_params = user_params.reject! { |k,v| v.blank? }
    if current_user.update(new_params)
      redirect_to troop_activities_path(current_user.troop), notice: 'Your account has been updated'
    else
      render :edit
    end
  end

  def url_after_create
    successful_signup_path
  end

  def successful_signup
    @title = "You are signed up - ScoutActivity"
  end

  def set_title
    @title = 'Profile | ScoutActivity'
  end

  def user_params
    params.require(:user).permit(:email, :password, :troop_id)
  end
end