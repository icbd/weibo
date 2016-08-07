require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user0 = users(:user0)
    @user1 = users(:user1)
    @user2 = users(:user2)
  end


  test "should get new" do
    get signup_path
    assert_response :success
  end


  test "未登录编辑用户,get, 转到login path" do
    get edit_user_path(@user0)
    assert_not flash.blank?
    assert_redirected_to login_path
  end

  test "未登录编辑用户, patch, 转到login path" do
    patch user_path(@user0), params: {
        user0: {
            name: @user0.name,
            email: @user0.email
        }
    }
    assert_not flash.blank?
    assert_redirected_to login_path
  end



end
