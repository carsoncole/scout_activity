task send_welcome_email: :environment do
  users = User.all.where('created_at > ? AND created_at < ?', Time.now - 4.days, Time.now - 1.day)
  users.each do |user|
    UserMailer.with(user: user).welcome_email.deliver_now
  end
end

task send_key_features_email: :environment do
  users = User.all.where('created_at > ? AND created_at < ?', Time.now - 25.days, Time.now - 7.days)
  users.each do |user|
    UserMailer.with(user: user).key_features_email.deliver_now
  end
end

task send_master_report_email: :environment do
  next unless Date.today.monday?

  AdminMailer.master_report.deliver_now
  puts 'Done'
end
