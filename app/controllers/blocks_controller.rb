class BlocksController < ApplicationController
  before_action :build_block, only: :move

  def move
    @block.insert_at(build_block_params.dig(:position).to_i)

    head :ok
  end

  protected

  def build_block
    @block = Post.find(build_block_params.dig(:post_id).to_i).blocks.find(build_block_params.dig(:id).to_i)
  end

  def build_block_params
    params.permit(:position, :id, :post_id)
  end
end
