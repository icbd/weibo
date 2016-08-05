class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "欢迎来到社区:)"
      # 新建用户直接登录
      log_in(@user)
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  private

  # 健壮方法
  def user_params
    params.require(:user).permit(
        :name, :email, :password, :password_confirmation
    )
  end

end
