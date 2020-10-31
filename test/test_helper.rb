ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  def sign_in
    @user = create(:user)
    visit sign_in_url
    within "#clearance.sign-in" do
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_on "Sign in"
    end
    assert_selector "h1", text: "Vote"
  end
end
