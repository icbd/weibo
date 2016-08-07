require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    # 获取在fixture中init的用户user0
    @user0 = users(:user0)
  end


  test "非法用户登录" do
    get login_path
    assert_template 'login/new'

    post login_path, params: {
        session: {
            email: '',
            password: ''
        }
    }

    assert_template 'login/new'

    assert_not flash.blank?

    get root_path
    assert flash.blank?
  end


  test "用户合法登录, 后接退出" do
    get login_path
    assert_template 'login/new'

    post login_path, params: {
        session: {
            email: @user0.email,
            password: '123456'
        }
    }

    # TEST ENV 专用
    assert logged_in_TEST?

    assert_redirected_to user_path(@user0)

    follow_redirect!
    assert_template 'users/show'

    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", user_path(@user0)
    assert_select "a[href=?]", logout_path

    # >> 后接 登出

    delete logout_path

    assert_not logged_in_TEST?

    assert_redirected_to root_url

    # 此时已经退出, 模拟用户在另一个Tab点击退出
    # 无处理则报 undefined method `forget' for nil:NilClass
    delete logout_path

    follow_redirect!

    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user0), count: 0
  end


end
