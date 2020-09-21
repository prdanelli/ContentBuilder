# frozen_string_literal: true

class BlockReflex < ApplicationReflex
  before_reflex :build_post, only: %w(create destroy)

  def create
    block = @post.blocks.build(permitted_params)

    block.save
  end

  def destroy
    @post.blocks.find(block_id).destroy

    @post.reload
  end

  protected

  def permitted_params
    params.require(:post).permit(blocks_attributes: :type).dig(:blocks_attributes).find { |p| p.dig(:type) }
  end

  def build_post
    @post ||= Post.find(element.dataset.dig(:post_id).to_i)
  end

  def block_id
    element.dataset.dig(:id).to_i
  end
end
