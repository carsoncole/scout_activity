# task :send_welcome_email, [:schedule] => :environment do |t, args|
#   schedule = args[:schedule] || ""
#   Review.scrape(schedule)
# end

task :send_welcome_email => :environment do
  users = User.all.where("created_at > ? AND created_at < ?", Time.now-4.days, Time.now - 1.day)
  users.each do |user|
    UserMailer.with(user: user).welcome_email.deliver_now
  end
end