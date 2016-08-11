require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:user0)
    @micropost = @user.microposts.build(content: "微博内容")

  end

  test "合法" do
    assert @micropost.valid?
  end

  test "非法" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "内容不得为空" do
    @micropost.content = "  "
    assert_not @micropost.valid?
  end

  test "内容不得超过140个字" do
    @micropost.content = 'a'*141
    assert_not @micropost.valid?
  end

  test "微博顺序" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
