class ApplicationMailer < ActionMailer::Base
  default from: 'scoutactivity@gmail.com'
  layout 'mailer'

  before_action :set_user

  def set_user
    if params && params[:user]
      @user = params[:user]
    end
  end
end
