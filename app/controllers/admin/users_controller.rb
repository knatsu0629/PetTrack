class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.update(is_active: false)
    redirect_to admin_dashboards_path, notice: 'ユーザーは退会しました。'
  end 
end
