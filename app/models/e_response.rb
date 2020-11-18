class EResponse < ApplicationRecord
  belongs_to :epreuve
  belongs_to :student
  belongs_to :user
  belongs_to :salle_de_class

  has_one_attached :fichier
end
