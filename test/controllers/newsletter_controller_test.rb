require 'test_helper'

class NewsletterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get newsletter_index_url
    assert_response :success
  end

  test "should get show" do
    get newsletter_show_url
    assert_response :success
  end

  test "should get edit" do
    get newsletter_edit_url
    assert_response :success
  end

  test "should get new" do
    get newsletter_new_url
    assert_response :success
  end

  test "should get update" do
    get newsletter_update_url
    assert_response :success
  end

  test "should get create" do
    get newsletter_create_url
    assert_response :success
  end

  test "should get destroy" do
    get newsletter_destroy_url
    assert_response :success
  end

end
