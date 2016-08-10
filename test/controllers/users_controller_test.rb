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

  test "登录后才能访问用户列表页面" do
    get users_path
    assert_redirected_to login_path
  end

  test "管理员权限非法获取" do
    log_in_as(@user1)
    assert_not @user1.admin?

    pw = '123456'
    patch user_path(@user1), params: {
        user: {
            password: pw,
            password_confirmation: pw,
            admin: true
        }
    }

    assert_not @user1.reload.admin?
  end


end
