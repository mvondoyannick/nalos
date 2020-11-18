class TimeTable < ApplicationRecord
  belongs_to :filiere
  belongs_to :salle_de_class
  belongs_to :structure
  validates :periode_debut, :periode_fin, presence: true

  has_one_attached :file
end
