module Blocks
  class Image < ::Block
    has_one_attached :image

    def self.field_type
      :file_field
    end
  end
end
