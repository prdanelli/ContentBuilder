class Post < ApplicationRecord
  has_many :blocks
  accepts_nested_attributes_for :blocks, allow_destroy: true
end
