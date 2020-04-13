class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  # action view
  has_rich_text :content
end
