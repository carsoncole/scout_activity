class UserMailer < ApplicationMailer
  def welcome_email
    @created_unit = @user.unit.present?
    @created_activities = @user.unit if @created_units
    mail to: @user.email
  end
end
