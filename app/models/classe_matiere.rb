class ClasseMatiere < ApplicationRecord
  belongs_to :salle_de_class
  belongs_to :matiere
end
