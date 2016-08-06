class LoginController < ApplicationController
  # GET /login
  # 登录展示
  def new
  end

  # POST /login
  # 登录动作
  def create
    user = User.find_by(email: params[:session][:email])
    if user
      if user.authenticate(params[:session][:password])
        # login success
        flash.now[:success] = '欢迎回来'

        # helper func
        log_in(user)

        # 记住我复选框
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)

        return redirect_to user_url(user)

      else
        flash.now[:danger] = '密码错误'
      end
    else
      flash.now[:danger] = '该邮箱尚未注册'
    end

    # 没有登录成功回到new页面再次尝试登录
    render 'login/new'
  end

  # DELETE /login
  # 登出
  def destroy
    # 没登录就log_out会抛异常 undefined method `forget' for nil:NilClass
    log_out if logged_in?
    redirect_to root_url
  end

end
