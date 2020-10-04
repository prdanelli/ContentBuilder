module Blocks
  class RichTextArea < ::Block
    has_rich_text :content

    def self.field_type
      :rich_text_area
    end
  end
end
