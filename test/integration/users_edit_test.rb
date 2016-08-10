require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user0 = users(:user0)
  end

  test "编辑用户信息 失败" do
    log_in_as(@user0)

    get edit_user_path(@user0)
    assert_template 'users/edit'
    patch user_path(@user0), params: {
        user: {
            name: '',
            email: '',
            password: ''
        }
    }

    assert_template 'users/edit'
    assert_select "div.alert-danger"

  end


  test "编辑用户信息 成功" do
    log_in_as(@user0)

    get edit_user_path(@user0)
    assert_template 'users/edit'

    name = 'Changed'
    email = 'Changed@gmail.com'
    patch user_path(@user0), params: {
        user: {
            name: name,
            email: email
        }
    }

    assert_redirected_to user_path(@user0)

    follow_redirect!
    assert_select "div.alert-success"

    @user0.reload
    assert_equal @user0.name, name
    assert_equal @user0.email, email.downcase

  end

  test "友好的重定向" do
    get edit_user_path(@user0)
    log_in_as(@user0)

    assert_redirected_to edit_user_path(@user0)

    name = "New Name"
    email = "newEmail@gmail.com"

    patch user_path(@user0), params: {
        user: {
            name: name,
            email: email
        }
    }

    assert_redirected_to user_url(@user0)
    @user0.reload

    assert_equal @user0.name, name
    assert_equal @user0.email, email.downcase

  end

end
