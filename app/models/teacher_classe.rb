class TeacherClasse < ApplicationRecord
  belongs_to :user
  belongs_to :salle_de_class
  belongs_to :matiere

  def name_with_initial
    (matiere.name).to_s
  end

  def class_with_initial
    (salle_de_class.name).to_s
  end

end
