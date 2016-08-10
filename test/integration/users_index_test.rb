require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user0)
  end


  test "index 分页" do
    log_in_as(@user)
    get users_path

    assert_template 'users/index'
    assert_select 'div.pagination'

    User.paginate(page: 1).each do |per_user|
      assert_select 'a[href=?]', user_path(per_user), text: per_user.name
    end

  end
end
