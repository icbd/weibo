require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user0)
  end

  test "编辑用户信息 失败" do

    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
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

    get edit_user_path(@user)
    assert_template 'users/edit'

    name = 'Changed'
    email = 'Changed@gmail.com'
    patch user_path(@user), params: {
        user: {
            name: name,
            email: email
        }
    }

    assert_redirected_to user_path(@user)

    follow_redirect!
    assert_select "div.alert-success"

    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email.downcase

  end


end
