class AddContentToBlocks < ActiveRecord::Migration[6.0]
  def change
    add_column :blocks, :content, :text, after: :position
  end
end
