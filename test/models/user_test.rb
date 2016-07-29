require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user1 = User.new(
        name: "User1 Name",
        email: "user1@hello.com",
        password: "p@ssW0rd",
        password_confirmation: "p@ssW0rd",
    )
  end

  test "user1 should be valid" do
    assert @user1.valid?
  end

  test "user's name 不为空" do
    @user1.name = "  "
    assert_not @user1.valid?
  end

  test "user's email 不为空" do
    @user1.email = '  '
    assert_not @user1.valid?
  end

  test "email 长度最大255" do
    err_email = "a"*(255-10+1)+ "@gmail.com"
    puts "email是:#{err_email}\n长度为:#{err_email.length}"
    @user1.email = err_email

    assert_not @user1.valid?
  end

  test "email 格式合法性通过测试" do
    email_arr = %w[user@gmail.com USER@gmail.com user.1@gmail.com user.1@gmail.com.cn user+test@gmail.com user_1@gmail.com user-1@gmail.com]

    email_arr.each do |email|
      @user1.email = email
      assert @user1.valid?, "#{email} 理应是合法的"
    end
  end

  test "email 格式合法性拦截测试" do
    email_arr = %w[user@gmail,com user#gamil.com user_at_gamil.com user@gamil_com user@g_amil.com user@gamil+hotmail.com @gamil.com]

    email_arr.each do |email|
      @user1.email = email
      assert_not @user1.valid?, "#{email} 理应是非法的"
    end
  end

  test "email 应该唯一(不区分大小写)" do
    copy_user = @user1.dup
    copy_user.email = copy_user.email.downcase
    @user1.save
    assert_not copy_user.valid?
  end

  test "email 小写落库" do
    str = "User888@Gmail.com"
    @user1.email = str
    @user1.save

    assert_equal @user1.reload.email, str.downcase
  end

  test " password 长度不小于6" do
    pswd = '12345'
    @user1.password = pswd
    @user1.password_confirmation = pswd

    assert_not @user1.valid?
  end

  test " password 不为空" do
    pswd = ''
    @user1.password = pswd
    @user1.password_confirmation = pswd

    assert_not @user1.valid?
  end


end
