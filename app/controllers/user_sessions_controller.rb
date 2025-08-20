class UserSessionsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      flash[:success] = "ログインしました"
      redirect_back_or_to root_path
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end
end
