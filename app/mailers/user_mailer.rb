class UserMailer < ApplicationMailer
  def welcome_email
    @unit = @user.unit
    return unless (@user.unit && @user.is_owner?) || !@user.unit
    mail to: @user.email, subject: 'Welcome to ScoutActivity'
  end
end
