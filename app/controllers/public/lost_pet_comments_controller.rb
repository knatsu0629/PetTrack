class Public::LostPetCommentsController < ApplicationController
    before_action :check_guest_user, only: [:create, :destroy]

  def create
    @lost_pet = LostPet.find(params[:lost_pet_id])
    @lost_pet_comment = @lost_pet.lost_pet_comments.new(comment_params)
    @lost_pet_comment.user = current_user
  
    if @lost_pet_comment.save
      redirect_to lost_pet_path(@lost_pet)
    else
      render 'lost_pets/show'
    end
  end

  def destroy
    @comment = LostPetComment.find(params[:id])
    @comment.destroy if @comment.user == current_user
    redirect_to lost_pet_path(@comment.lost_pet)
  end

  def show
    @lost_pet = LostPet.find(params[:id])
    @lost_pet_comment = LostPetComment.new
  end
  

  private

  def check_guest_user
    if current_user && current_user.email == 'guest@example.com'
      redirect_to lost_pets_path, alert: 'ゲストユーザーはこの操作を行えません。'
    end
  end

  def comment_params
    params.require(:lost_pet_comment).permit(:comment)
  end
end
