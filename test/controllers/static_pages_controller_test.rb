require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = " |weibo"
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success

    assert_select "title", "home#{@base_title}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success

    assert_select "title", "help#{@base_title}"
  end

  test "应该 GET about" do
    get static_pages_about_url
    assert_response :success

    assert_select "title", "about#{@base_title}"
  end

  test "应该 GET contact" do
    get static_pages_contact_url
    assert_response :success

    assert_select "title", "contact#{@base_title}"
  end

  test "should GET root" do
    get root_url
    assert_response :success
  end

end
