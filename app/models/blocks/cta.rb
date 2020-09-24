module Blocks
  class Cta < ::Block
    has_many :blocks, foreign_key: :parent_id
    accepts_nested_attributes_for :blocks, allow_destroy: true

    def self.fields
      %w(Blocks::Text Blocks::Text Blocks::Textarea).map { |type| type.constantize.new }
    end
  end
end
