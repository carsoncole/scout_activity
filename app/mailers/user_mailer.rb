class UserMailer < ApplicationMailer
  def welcome_email
    @unit = @user.unit
    return unless (@user.unit && @user.admin_or_owner?) || !@user.unit
    return if @user.logs.where(mailer_instance: 'welcome_email').any?

    mail to: @user.email, subject: 'Welcome to ScoutActivity'
    Log.create(mailer_instance: 'welcome_email', user_id: @user.id)
  end

  def key_features_email
    @unit = @user.unit
    return unless (@user.unit && @user.is_owner?) || !@user.unit
    return if @user.logs.where(mailer_instance: 'key_features_email').any?

    mail to: @user.email, subject: "Key features I'd like to tell you about"
    Log.create(mailer_instance: 'key_features_email', user_id: @user.id)
  end
end
