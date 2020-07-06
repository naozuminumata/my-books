class CommentsController < ApplicationController

  def create
    @comment = @current_user.comments.build(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post_id = @post.post_id
    
    @comments = Comment.where(post_id: params[:post_id])

    @comment.save
    respond_to :js
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = 'コメントの更新が完了しました'
      redirect_back(fallback_location: root_path)
    else
      respond_to :js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました'
    redirect_back(fallback_location: root_path)
  end

  def index
    @comment = Comment.new
    @comments = Comment.where(post_id: params[:post_id])
    @post = Post.find(params[:post_id])
    respond_to :js
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end