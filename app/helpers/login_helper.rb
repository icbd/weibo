## 该模块首先注入到Application Controller中, 让身份验证在全局使用
## Login Helper Func, 处理session
module LoginHelper


  # 能在session中取到:user_id就表示在线
  #  remember me为在cookies中取到 :user_id
  def log_in(user)
    session[:user_id] = user.id
  end


  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end


  # 已登录(Session)/记住我(RememberMe)
  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif user_id = cookies.signed[:user_id]
      true_user = User.find_by(id: user_id)
      if true_user and true_user.authenticated?(cookies[:remember_token])
        log_in(true_user)
        @current_user = true_user
      end
    end
  end

  def current_user?(user)
    current_user == user
  end


  def logged_in?
    !current_user.nil?
  end


  # 先忘记, 再销毁当前
  def log_out
    forget(current_user)

    session.delete(:user_id)
    @current_user = nil
  end


  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 暂存想要访问的位置
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  # 登录后回到想要访问的位置或默认位置
  def redirect_back_or_goto(default_url)
    url = session[:forwarding_url] || default_url
    redirect_to(url)
    session.delete(:forwarding_url)
  end


end
