class LikesController < ApplicationController

  def create
    @path = Rails.application.routes.recognize_path(request.referer)
    @like = Like.new(
      user_id: @current_user.id,
      post_id: params[:post_id]
    )
    @like.save
    @post = Post.find_by(id: params[:post_id])
    @post.like_count = Like.where(post_id: @post.id).count
    @post.save
  end

  def destroy
    @path = Rails.application.routes.recognize_path(request.referer)
    @like = Like.find_by(
      user_id: @current_user.id,
      post_id: params[:post_id]
    )
    @like.destroy
    @post = Post.find_by(id: params[:post_id])
    @post.like_count = Like.where(post_id: @post.id).count
    @post.save
  end

end