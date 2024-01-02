class UsersController < ApplicationController
  skip_before_action :require_login

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
      flash[:success] = "ユーザーを登録しました"
    else
      flash.now[:danger] = "ユーザーを登録できませんでした"
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end

end
