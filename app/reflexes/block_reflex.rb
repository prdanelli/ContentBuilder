# frozen_string_literal: true

class BlocksReflex < ApplicationReflex
  before_reflex :build_post, only: %w(update)

  def update
    binding.pry
    @post.update(permitted_params)

    @post
  end

  protected

  def permitted_params
    params.require(:post).permit(:id, :title, blocks_attributes: {})
  end

  def build_post
    @post ||= Post.find(params.require(:id))
  end
end
