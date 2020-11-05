require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "master_report" do
    admin_user = create(:user, is_admin: true, email: 'admin@example.com')
    mail = AdminMailer.master_report
    assert_equal "ScoutActivity Management Report", mail.subject
    assert_equal ["admin@example.com"], mail.to
    assert_equal ["scoutactivity@gmail.com"], mail.from
    assert_match "ScoutActivity Report", mail.body.encoded
  end

end
