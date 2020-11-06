class UsersController < Clearance::UsersController
  before_action :require_login, except: [:unsubscribe, :new, :create]
  before_action :set_title, only: [:edit]

  def edit
    @user = current_user
  end

  def new
    @unit = Unit.find(params[:unit_id]) if params[:unit_id]
    super
  end

  def update
    @user = current_user
    new_params = user_params
    new_params = user_params.reject! { |k,v| v.blank? }
    if current_user.update(new_params)
      redirect_to unit_activities_path(current_user.unit), notice: 'Your account has been updated'
    else
      render :edit
    end
  end

  def unsubscribe
    @user = User.find(params[:user_id])
    @user.update(is_subscribed: false)
  end

  def url_after_create
    successful_signup_path(signup: 'success')
  end

  def successful_signup
    @title = "You are signed up - ScoutActivity"
  end

  def set_title
    @title = 'Profile - ScoutActivity'
  end

  def user_params
    params.require(:user).permit(:email, :password, :unit_id, :is_subscribed)
  end
end