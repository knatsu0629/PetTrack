class Public::LostPetTagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @lost_pets = @tag.lost_pets.order(created_at: :desc)
  end
end