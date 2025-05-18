class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @liked_posts = current_user.liked_posts.includes(:likes)
  end

  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.new(post: post)

    if like.save
      redirect_back fallback_location: posts_path, notice: 'いいねしました'
    else
      redirect_back fallback_location: posts_path, alert: 'いいねできませんでした'
    end
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    if like
      like.destroy
      redirect_back fallback_location: posts_path, notice: 'いいねを取り消しました'
    else
      redirect_back fallback_location: posts_path, alert: 'いいねを取り消せませんでした'
    end
  end

end
