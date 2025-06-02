class Public::TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.includes(:user)
  end
end

