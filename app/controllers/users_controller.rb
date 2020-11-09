class UsersController < Clearance::UsersController
  before_action :require_login, except: [:unsubscribe, :new, :create]
  before_action :set_title, only: [:edit]

  def edit
    @user = User.find(params[:id])
    unless @user == current_user || current_user.admin_or_owner? && @user.unit == current_user.unit
      redirect_to root_path
    end
  end

  def new
    @unit = Unit.find(params[:unit_id]) if params[:unit_id]
    super
  end

  def update
    @user = User.find(params[:id])
    redirect_to root_path unless current_user == @user || (current_user.admin_or_owner? && current_user.unit == @user.unit)
    new_params = user_params
    new_params = user_params.reject! { |k,v| v.blank? }
    if @user.update(new_params)
      if current_user == @user
        redirect_to unit_activities_path(current_user.unit), notice: 'Your account has been updated'
      else
        redirect_to edit_unit_path(@user.unit), notice: 'The account has been updated'
      end
    else
      byebug
      puts @user.errors.full_messages
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
    params.require(:user).permit(:email, :password, :unit_id, :is_subscribed, :is_admin)
  end
end