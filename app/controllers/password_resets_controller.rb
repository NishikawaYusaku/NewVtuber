class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    if logged_in?
      @user = User.find(current_user.id)
      @user&.deliver_reset_password_instructions!
      redirect_to user_path
      flash[:success] = 'パスワード変更のメールを送信しました'
    else
        @user = User.find_by(email: params[:email])
      if @user
        @user&.deliver_reset_password_instructions!
        redirect_to login_path
        flash[:success] = 'パスワードリセットのメールを送信しました'
      else
        flash.now[:danger] = "パスワードリセットのメールを送信できませんでした"
        render :new
      end
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?

    @password = params[:user][:password]
    @password_confirmation = params[:user][:password_confirmation]

    @user.password_confirmation = @password_confirmation
    if (@password.present? && @password_confirmation.present?) && (@password == @password_confirmation) && @user.change_password(@password)
      if logged_in?
        redirect_to user_path
        flash[:success] = 'パスワードを変更しました'
      else
        redirect_to login_path
        flash[:success] = 'パスワードを変更しました'
      end
    else
      flash.now[:danger] = 'パスワードを変更できませんでした'
      render :edit
    end
  end
end
