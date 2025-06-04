class Public::LostPetsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :new, :create, :destroy]
  before_action :set_lost_pet, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :reject_guest_user, only: [:new, :create, :edit, :update, :destroy]


  def index
    @lost_pets = LostPet.page(params[:page])
    respond_to do |format|
      format.html
      format.json do
        render json: {
          data: {
            items: LostPet.all.map do |pet|
              {
                id: pet.id,
                title: pet.title,
                name: pet.name,
                gender: pet.gender,
                animal_type: pet.animal_type,
                feature: pet.feature,
                latitude: pet.latitude,
                longitude: pet.longitude,
                image_url: pet.image.attached? ? url_for(pet.image) : nil,
                last_seen_location: pet.last_seen_location
              }
            end
          }
        }
      end
    end
  end
  

  def show
    @lost_pet = LostPet.find(params[:id])
    @lost_pet_comments = @lost_pet.lost_pet_comments.includes(:user)
    @q = LostPet.ransack(params[:q])
    @lost_pets = @q.result(distinct: true)
  end

  def new
    @lost_pet = LostPet.new
  end

  def create
    @lost_pet = current_user.lost_pets.new(lost_pet_params)
    if @lost_pet.save
      save_tags(@lost_pet, params[:lost_pet][:tag_names])
      redirect_to lost_pets_path
    else
      render :new
    end
  end

  def edit
    @lost_pet = LostPet.find(params[:id])
  end

  def update
    @lost_pet = LostPet.find(params[:id])
    if @lost_pet.update(lost_pet_params)
      save_tags(@lost_pet, params[:lost_pet][:tag_names])
      redirect_to lost_pet_path(@lost_pet.id), notice: '迷子ペット情報を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @lost_pet.destroy
    redirect_to lost_pets_path, notice: '迷子ペット情報を削除しました。'
  end

private

  def set_lost_pet
    @lost_pet = LostPet.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to lost_pets_path, alert: '迷子ペット情報が見つかりませんでした。'
  end

  def lost_pet_params
    params.require(:lost_pet).permit(
      :title, :name, :animal_type, :gender, :feature, :description,
      :missing_date, :last_seen_location, :latitude, :longitude, :status, :image, :address, :tag_list
      ).merge(gender: params[:lost_pet][:gender].to_i)
  end

  def ensure_correct_user
    @lost_pet = LostPet.find(params[:id])
    unless @lost_pet.user == current_user
      redirect_to lost_pets_path
    end
  end

  def reject_guest_user
    if current_user&.guest_user?
      redirect_to lost_pets_path
    end
  end

  def save_tags(lost_pet, tag_names)
    return if tag_names.blank?

    tag_list = tag_names.split(/[,\s ]+/).uniq
    tags = tag_list.map { |name| Tag.find_or_create_by(name: name.strip) }
    lost_pet.tags = tags
  end
end

