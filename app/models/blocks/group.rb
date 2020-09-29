module Blocks
  class Group < Block
    has_many :blocks, foreign_key: :parent_id
    accepts_nested_attributes_for :blocks, allow_destroy: true

    serialize :content
  end
end
