class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @keyword = params[:keyword]
  
    if @model == "user"
      @results = User.where("name LIKE ?", "%#{@keyword}%")
    elsif @model == "post"
      @results = Post.where("caption LIKE ?", "%#{@keyword}%")
    else
      flash[:alert] = "検索対象を選んでください"
      @results = []  
    end
  end
end