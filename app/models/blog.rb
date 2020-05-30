class Blog < ApplicationRecord
  belongs_to :user

  validates :title, :categorie, presence: true

  has_rich_text :content
end
