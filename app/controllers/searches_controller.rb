class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @keyword = params[:keyword]
  
    if @model == "user"
      @users = User.where("name LIKE ?", "%#{@keyword}%")
    elsif @model == "post"
       @posts = Post.where("caption LIKE ?", "%#{@keyword}%")
    else
      flash[:alert] = "検索対象を選んでください"
    end
  end
end