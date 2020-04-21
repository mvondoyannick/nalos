class Comment < ApplicationRecord
  belongs_to :student
  belongs_to :course
  belongs_to :student
  belongs_to :user

  before_save :set_read, if: :new_record?

  # action view
  has_rich_text :content

  private

  def set_read
    self.read = false
    self.metakey = SecureRandom.hex(10).upcase
  end
end
