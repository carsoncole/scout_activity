require 'test_helper'

class NewsletterMailerTest < ActionMailer::TestCase
  test "2020November10" do
    mail = NewsletterMailer.2020November10
    assert_equal "2020november10", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
