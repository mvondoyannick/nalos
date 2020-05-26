class TeacherClasse < ApplicationRecord
  belongs_to :user
  belongs_to :salle_de_class
  belongs_to :matiere

  def name_with_initial
    "#{matiere.name}"
  end

  def class_with_initial
    "#{salle_de_class.name}"
  end

end
