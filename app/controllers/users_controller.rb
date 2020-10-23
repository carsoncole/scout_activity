class UsersController < Clearance::UsersController

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    new_params = user_params
    new_params = user_params.reject! { |k,v| v.blank? }
    if current_user.update(new_params)
      redirect_to edit_user_path(current_user), notice: 'Your account has been updated'
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :troop_id)
  end
end