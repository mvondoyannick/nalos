class JfnSupportCourse < ApplicationRecord
  belongs_to :user
  has_one_attached :document
  has_rich_text :content_description
  validates :content_description, presence: true
end
