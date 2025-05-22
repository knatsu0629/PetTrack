class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update]

  def ensure_guest_user
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは編集できません。'
    end
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), alert: '他のユーザーのプロフィールは編集できません。'
    end
  end

  def show
    @user = User.find(params[:id])
    @following_count = @user.followings.count
    @followers_count = @user.followers.count
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'プロフィールが更新されました'
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to new_user_registration_path, notice: '退会が完了しました。ご利用ありがとうございました。'
  end

  def search
    @users = User.where("name LIKE ?", "%#{params[:keyword]}%")
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
    @followings = @user.followings.page(params[:page]).per(10) 
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    @followers = @user.followers.page(params[:page]).per(10)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :avatar) 
  end
end
