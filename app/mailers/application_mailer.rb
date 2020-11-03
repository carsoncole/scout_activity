class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  before_action :set_user

  def set_user
    if params[:user]
      @user = params[:user]
    end
  end
end
