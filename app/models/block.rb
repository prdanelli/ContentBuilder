class Block < ApplicationRecord
  belongs_to :post

  scope :positioned, -> { order(position: :asc) }

  acts_as_list
end
