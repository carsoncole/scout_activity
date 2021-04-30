class UsersController < Clearance::UsersController
  before_action :require_login, except: %i[unsubscribe new create destroy]
  before_action :set_user, only: %i[edit update destroy]
  before_action :require_admin_owner, only: %i[edit update destroy]
  before_action :set_title, only: [:edit]

  def edit; end

  def update
    new_params = user_params.reject! { |_k, v| v.blank? }
    if @user.update(new_params)
      redirect_to unit_activities_path(@user.unit), notice: 'Your account has been updated'
    else
      render :edit
    end
  end

  def destroy
    @user.update(unit_id: nil)
    redirect_to edit_unit_path(@unit)
  end

  def unsubscribe
    @user = User.find(params[:user_id])
    @user.update(is_subscribed: false)
  end

  def url_after_create
    successful_signup_path(signup: 'success')
  end

  def successful_signup
    @title = 'You are signed up - Scout Activity'
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_title
    @title = 'Profile - Scout Activity'
  end

  def user_params
    params.require(:user).permit(:email, :password, :unit_id, :is_subscribed, :is_admin, :first_name, :last_name)
  end

  def require_admin_owner
    redirect_to root_path unless current_user == @user || (current_user.admin_or_owner? && current_user.unit == @user.unit)
  end
end
