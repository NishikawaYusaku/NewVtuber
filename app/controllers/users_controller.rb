class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[edit_email update_email edit_name update_name]

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
    @vtubers = current_user.favorite_vtubers
  end

  def edit_email
    @user.email = ""
  end

  def update_email
    if @user.update(user_params)
      redirect_to user_path
      flash[:success] = "メールアドレスを変更しました"
    else
      flash.now[:danger] = "メールアドレスを変更できませんでした"
      render :edit_name
    end
  end
=begin
  def edit_password
    @user.crypted_password = ""
  end

  def update_password
    binding.pry
    if @user.valid_password?(params[:user][:password_current])
      if (params[:user][:password] == params[:user][:password_confirmation])
        # @user.crypted_password = params[:user][:password]
        @user.update(aaa)
        redirect_to user_path
        flash[:success] = "パスワードを変更しました"
      else
        flash.now[:danger] = "新しいパスワードが一致しません"
        render :edit_password
      end
    else
      flash.now[:danger] = "現在のパスワードが間違っています"
      render :edit_password
    end
  end
=end

  def edit_name
    @user.name = ""
  end

  def update_name
    if @user.update(user_params)
      redirect_to user_path
      flash[:success] = "ユーザー名を変更しました"
    else
      flash.now[:danger] = "ユーザーを変更できませんでした"
      render :edit_name
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
