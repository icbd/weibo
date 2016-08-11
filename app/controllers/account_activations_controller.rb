class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in(user)
      flash[:success] = "账户激活成功"
      redirect_to user_path(user)
    else
      flash[:danger] = "账户激活失败"
      redirect_to root_url
    end
  end
end
