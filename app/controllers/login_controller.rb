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

        log_in(user) # helper func


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
    log_out
    redirect_to root_url
  end

end
