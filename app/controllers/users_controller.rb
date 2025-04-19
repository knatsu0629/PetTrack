class UsersController < ApplicationController
  before_action :authenticate_user!  
  
  def show
    @user = current_user
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

  def guest_sign_in
  end
    

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction) 
  end
end
