class PostsController < ApplicationController

  before_action :set_post, only: [ :edit, :update, :destroy]

  def show
    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end
  end

  def create
    params.inspect
    @post = Post.create(post_params.merge(user_id: current_user.id))
    @user = User.find(current_user.id)
    @user.posts << @post
    redirect_to posts_url
  end

  def index
    @posts = Post.order_by_created_at
    @post = Post.new
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.inspect
    params.require(:post).permit(:message, :image)
  end
end
