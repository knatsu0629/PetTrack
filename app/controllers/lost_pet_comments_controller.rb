class LostPetCommentsController < ApplicationController
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

  def comment_params
    params.require(:lost_pet_comment).permit(:comment)
  end
end
