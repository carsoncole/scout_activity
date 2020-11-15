require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
  end

  test "viewing a user logged in and not logged in" do
    get edit_user_url(@user)
    assert_redirected_to sign_in_path

    get edit_user_path(@user, as: @user)
    assert_response :success
  end

  test "updating a user's own profile" do
    get edit_user_path(@user, as: @user)
    assert_response :success
    patch user_path(@user, as: @user), params: { user: { email: 'newemail@example.com' }}
    assert_equal 'newemail@example.com', @user.reload.email
  end

  test "updating a user's with a blank email" do
    get edit_user_path(@user, as: @user)
    original_email = @user.email
    assert_response :success
    patch user_path(@user, as: @user), params: { user: { email: 'junk' }}
    assert_response :success # render :edit
    assert_equal original_email, @user.reload.email
  end

  test "updating a user's by a different unit user" do
    user_2 = create(:user)
    get edit_user_path(@user, as: user_2)
    assert_redirected_to root_path # blocked


    patch user_path(@user, as: user_2), params: { user: { email: 'myemail@example.com' }}
    assert_redirected_to root_path # blocked
  end
end
