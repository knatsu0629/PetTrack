class PostsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @post = Post.new  
  end

  def create
    post = Post.new(post_params)
    if post.save
      redirect_to post_path
    else
      render :new
    end    
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
