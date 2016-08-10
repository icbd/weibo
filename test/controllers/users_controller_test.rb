require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user0 = users(:user0) #admin
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


  test "非admin删除用户, 转到root" do
    log_in_as(@user1)
    assert_no_difference 'User.count' do
      delete user_path(@user0)
    end

    assert_redirected_to root_url
  end

  test "未登录删除用户, 转到root" do
    assert_no_difference 'User.count' do
      delete user_path(@user0)
    end

    assert_redirected_to login_path
  end

  test "非管理员看不到删除链接" do
    log_in_as(@user2)
    get users_path
    assert_select 'a', text: '删除', count: 0
  end

  test "管理员产出用户, 分页展示" do
    log_in_as(@user0)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'

    first_page_of_users = User.paginate(page: 1)

    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @user0
        assert_select 'a[href=?]', user_path(user), text: "删除该用户"
      end
    end


    assert_difference 'User.count', -1 do
      delete user_path(@user1)
    end
  end

end
