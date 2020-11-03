class UserMailer < ApplicationMailer
  def welcome_email
    @created_troop = @user.troop.present?
    @created_activities = @user.troop if @created_troops
    mail to: @user.email
  end
end
