class PostsController < ApplicationController

  before_action :authenticate_user,except: [:index]
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end

  def new
    @post = Post.new
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  def create
    @post = Post.new(
      title: params[:title],
      rating: params[:rating],
      review: params[:review],
      share: params[:share]
    )

    if @post.save
      redirect_to("/posts/index")
    else
      render("/posts/index")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
