class AddParentIdToBlocks < ActiveRecord::Migration[6.0]
  def change
    add_column :blocks, :parent_id, :integer
    add_index :blocks, :parent_id
  end
end
