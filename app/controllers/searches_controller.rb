class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @keyword = params[:keyword]
    @method = params[:method] 
  
    if @method == "perfect"
      search_word = @keyword
    else
      search_word = "%#{@keyword}%"
    end
  
    if @model == "user"
      @users = User.where("name LIKE ?", search_word)
    elsif @model == "post"
      @posts = Post.where("title LIKE ? OR body LIKE ?", search_word, search_word)
    elsif @model == "lost_pet"
      @lost_pets = LostPet.where("name LIKE ? OR feature LIKE ? OR animal_type LIKE ? OR last_seen_location LIKE ?", search_word, search_word, search_word, search_word)
    else
      flash[:alert] = "検索対象を選んでください"
    end

    @users ||= []
    @posts ||= []
    @lost_pets ||= []
  end
end 