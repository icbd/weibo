class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  # before_action :correct_user, only: [:edit, :update]

  # 前置方法, 转到root 除非确认是用户本人
  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  # 前置方法,登录后才能操作
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = '请登录'
      redirect_to login_path
    end
  end

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

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update

    @user = User.find_by(id: params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = '修改成功'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = '认证出错'
      render 'edit'
    end

  end

  private

  # 健壮方法
  def user_params
    params.require(:user).permit(
        :name, :email, :password, :password_confirmation
    )
  end

end
