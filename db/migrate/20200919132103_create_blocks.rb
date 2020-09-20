class CreateBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :blocks do |t|
      t.string :type
      t.belongs_to :post
      t.integer :position

      t.timestamps
    end
  end
end
