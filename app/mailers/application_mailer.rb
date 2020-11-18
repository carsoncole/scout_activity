class ApplicationMailer < ActionMailer::Base
  default from: 'ScoutActivity <scoutactivity@gmail.com>'
  layout 'mailer'

  before_action :set_user

  def set_user
    @user = params[:user] if params && params[:user]
  end
end
