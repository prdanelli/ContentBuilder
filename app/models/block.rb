class Block < ApplicationRecord
  belongs_to :post

  scope :positioned, -> { order(position: :asc) }
  scope :top_level, -> { where(parent_id: nil) }

  acts_as_list scope: :post

  def title
    self.class.name.demodulize
  end
end
