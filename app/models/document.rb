class Document < ApplicationRecord
  has_many_attached :file
    # belongs_to :user
  has_one :course, dependent: :delete # si on détruit un document, le cours lié est egalement détruit
  belongs_to :structure

  validates :file, presence: true
end
