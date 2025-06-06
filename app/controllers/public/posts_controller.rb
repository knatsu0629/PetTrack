class Public::PostsController < ApplicationController
  before_action :check_guest_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
 

  def check_guest_user
    if current_user.email == 'guest@example.com'
      redirect_to posts_path, alert: 'ゲストユーザーはこの操作を行えません。'
    end
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path, alert: '他のユーザーの投稿は編集できません。'
    end
  end

  def index
    if params[:filter] == "following" && user_signed_in?
      @posts = Post.where(user_id: current_user.following_ids).order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
  end

  def new
    @post = Post.new  
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      save_tags(@post, params[:tag_names])
      redirect_to posts_path
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end    
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      save_tags(@post, params[:tag_names])
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy  
    redirect_to posts_path
  end

  def search
    @posts = Post.where("caption LIKE ?", "%#{params[:keyword]}%")
  end
  
  def feed
    @posts = Post.where(user_id: current_user.followings.pluck(:id)).order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :tag_names)
  end

  def save_tags(post, tag_names)
    return if tag_names.blank?
  
    tag_list = tag_names.split(',').map(&:strip).uniq
    tags = tag_list.map { |name| Tag.find_or_create_by(name: name) }
  
    post.tags = tags
  end
end