require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Weibo With ROR5"
  end


  test "should GET root" do
    get root_url
    assert_response :success
  end

  test "should get help" do
    get help_path
    assert_response :success

    assert_select "title", "help | #{@base_title}"
  end

  test "应该 GET about" do
    get about_path
    assert_response :success

    assert_select "title", "about | #{@base_title}"
  end

  test "应该 GET contact" do
    get contact_path
    assert_response :success

    assert_select "title", "contact | #{@base_title}"
  end



end
