class AdminMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.master_report.subject
  #
  def master_report
    @new_users_count = User.where("created_at > ?", Time.now - 7.days).count
    @new_units_count = Unit.where("created_at > ?", Time.now - 7.days).count
    @new_activities_count = Activity.where("created_at > ?", Time.now - 7.days).count
    @active_users_count = User.active.all.count
    @total_users_count = User.all.count
    emails = User.admin.collect(&:email).join(",")
    mail to: emails, subject: "ScoutActivity Management Report"
  end
end
