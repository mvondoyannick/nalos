class Filiere < ApplicationRecord
  belongs_to :structure
  has_many :matieres
end
