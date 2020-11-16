require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "master_report" do
    create(:app_admin_user, email: 'admin@example.com')
    mail = AdminMailer.master_report
    assert_equal "ScoutActivity Management Report", mail.subject
    assert_equal ["admin@example.com"], mail.to
    assert_equal ["scoutactivity@gmail.com"], mail.from
    assert_match "ScoutActivity Report", mail.body.encoded
    mail.deliver_now
    assert_equal 1, ActionMailer::Base.deliveries.count
  end
end
