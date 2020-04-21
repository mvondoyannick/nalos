class Probleme < ApplicationRecord
  belongs_to :student

  has_rich_text :content
end
