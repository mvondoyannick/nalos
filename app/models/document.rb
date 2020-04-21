class Document < ApplicationRecord
  has_many_attached :file
    # belongs_to :user
  has_one :course
end
