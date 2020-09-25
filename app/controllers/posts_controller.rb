class PostsController < ApplicationController
  before_action :build_post, only: %w(edit update)

  def index
    @posts = Post.all
  end

  def new
    redirect_to edit_post_path(Post.create)
  end

  def update
    if @post.update(permitted_params)
      redirect_to posts_path, success: "Created Post"
    else
      flash[:danger] = @post.errors.full_messages
      render :edit
    end
  end

  protected

  def permitted_params
    params.require(:post).permit(:id, :title, blocks_attributes: {})
  end

  def build_post
    @post ||= Post.find(params.require(:id))
  end
end
