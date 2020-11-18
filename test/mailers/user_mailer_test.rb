require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'welcome_email' do
    user = create(:owner_user)
    mail = UserMailer.with(user: user).welcome_email
    assert_equal 'Welcome to ScoutActivity', mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['scoutactivity@gmail.com'], mail.from
    assert_match 'Welcome to ScoutActivity', mail.body.encoded
  end
end
