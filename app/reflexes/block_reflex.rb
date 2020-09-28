class BlockReflex < ApplicationReflex
  before_reflex :build_post, only: %w(create destroy)

  # Note: This is a work in progress, just trying to get it all working for now
  def create
    block_params = permitted_params.to_h

    if element.dataset.parent_type == "Blocks::Repeater"
      parent = @post.blocks.find(element.dataset.parent_id)
      block_params.merge!(parent_id: element.dataset.parent_id, post_id: @post.id, type: element.dataset.parent_type)

      block = parent.blocks.build(block_params)
      block.save

      block.content.split(" ").map { |type| block.blocks.create(type: type, parent_id: element.dataset.parent_id, post_id: @post.id) }
    else
      @post.blocks.build(block_params).save
    end
  end

  def destroy
    block = @post.blocks.find(element.dataset.dig(:id).to_i)
    # FIXME: For some reason deleting CTA doesn't delete child blocks - prolly the association is wrong some how
    block.blocks.destroy_all if @post.blocks.any?
    block.destroy

    @post.reload
  end

  protected

  def permitted_params
    params.permit(:type, :content)
  end

  # Prolly easier to get post from the param as it'll always be present
  def build_post
    @post ||= Post.find(params.dig(:id) || element.dataset.dig(:post_id).to_i)
  end
end
