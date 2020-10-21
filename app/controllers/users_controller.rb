class UsersController < Clearance::UsersController

  def user_params
    params.require(:user).permit(:email, :password, :troop_id)
  end
end