require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "非法注册" do
    get signup_path
    assert_no_difference "User.count" do
      post signup_path, params: {
          user: {
              name: "",
              email: "user@invalid",
              password: "foo",
              password_confirmation: "bar",
          }
      }
    end
    assert_template 'users/new'

    assert_select 'div#error_explanation'

    assert flash[:success].blank?
  end

  test "合法注册" do
    get signup_path
    assert_difference "User.count", 1 do
      post signup_path, params: {
          user: {
              name: "Legal User",
              email: "legaluser#{Time.now.to_i}@gmail.com",
              password: "Password!1",
              password_confirmation: "Password!1"
          }
      }
    end

    follow_redirect!
    assert_template 'users/show'
  end
end
