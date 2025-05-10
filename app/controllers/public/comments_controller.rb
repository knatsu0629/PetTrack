class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]
  before_action :authorize_user!, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_back fallback_location: post_path(@post), notice: "コメントを追加しました"
    else
      redirect_back fallback_location: post_path(@post), alert: "コメントを追加できませんでした"
    end
  end

  def destroy
    @comment.destroy
    redirect_back fallback_location: post_path(@comment.post), notice: "コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_user!
    redirect_back(fallback_location: root_path, alert: "権限がありません") unless @comment.user == current_user
  end
end
