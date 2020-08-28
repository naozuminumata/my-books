class PostsController < ApplicationController
  # protect_from_forgery
  # before_action :authenticate_user,except: [:index]

  before_action :authenticate_user!, except: :index
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    if user_signed_in?
      @post = Post.new
    else
      flash[:notice] = "ログインが必要です"
      redirect_to(user_session_path, method: :post)
    end
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to("/posts/index")
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("/posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :rating, :review, :amazon_url, :isbn_code, :share)
  end

end
