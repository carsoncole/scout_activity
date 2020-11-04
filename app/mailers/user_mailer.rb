class UserMailer < ApplicationMailer
  def welcome_email
    @unit = @user.unit
    return unless (@user.unit && @user.is_owner?) || !@user.unit
    return if @user.logs.where(mailer_instance: 'welcome_email').any?
    mail to: @user.email, subject: '[RESEND] Welcome to ScoutActivity'
    Log.create(mailer_instance: 'welcome_email', user_id: @user.id)
  end
end
