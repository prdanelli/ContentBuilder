class BlockReflex < ApplicationReflex
  before_reflex :build_post, only: %w(create destroy)

  # NOTE: This is a work in progress, just trying to get it all working for now
  # TODO: Split method into builder methods on the block, so each class is responsible for building its self
  def create
    if element.dataset.parent_type == "Blocks::Repeater"
      repeater = @post.blocks.find(element.dataset.parent_id)
      repeater.update(content: permitted_params.require(:content))

      group = repeater.blocks.create(type: "Blocks::Group", parent_id: repeater.id, post_id: @post.id)

      repeater.content.split(" ").map do |type|
        group.blocks.create(type: type, post_id: @post.id)
      end

    else
      @post.blocks.create(permitted_params.to_h)
    end
  end

  def destroy
    block = @post.blocks.find(element.dataset.dig(:id).to_i)
    # FIXME: For some reason deleting CTA doesn't delete child blocks - prolly the association is wrong some how
    block.blocks.destroy_all if block.respond_to?(:blocks) && block.blocks.any?
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
