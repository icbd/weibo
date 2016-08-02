ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# 测试高亮
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # 引入项目里的帮助方法
  include ApplicationHelper


  # helper func
  # 测试环境中不能使用正式中的方法, 遂 复制一个一模一样的过来
  def logged_in_TEST?
    !session[:user_id].nil?
  end
end
