class Message < ApplicationRecord
  belongs_to :student
  belongs_to :user

  has_rich_text :content
  has_many_attached :file

  validates :content, presence: true

end
