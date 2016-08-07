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

  # def log_in_as(user)
  #   session[:user_id] = user.id
  # end

  ## 集成测试
  class ActionDispatch::IntegrationTest

    # 简化测试过程中重复的post登录动作
    def log_in_as(user, password='123456', remember_me: '1')
      post login_path, params: {
          session: {
              email: user.email,
              password: password,
              remember_me: remember_me
          }
      }
    end
  end


end
