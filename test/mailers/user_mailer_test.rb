require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = users(:user0)
    user.activation_token = User::new_token
    mail = UserMailer.account_activation(user)

    assert_equal [user.email], mail.to
  end

end
