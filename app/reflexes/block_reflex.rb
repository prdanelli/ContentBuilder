class BlockReflex < ApplicationReflex
  before_reflex :build_post, only: %w(create destroy)

  def create
    block = @post.blocks.build(permitted_params)

    block.save
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
    params.permit(:type)
  end

  # Prolly easier to get post from the param as it'll always be present
  def build_post
    @post ||= Post.find(element.dataset.dig(:post_id).to_i)
  end
end
