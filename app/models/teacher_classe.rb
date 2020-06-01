class TeacherClasse < ApplicationRecord
  belongs_to :user
  belongs_to :salle_de_class
  belongs_to :matiere
  belongs_to :structure

  # validation

  def name_with_initial
    "#{matiere.name}"
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      current_teacher = User.find_by_matricule(row[0])
      current_classe = SalleDeClass.find_by_name(row[2])
      current_matiere = Matiere.find_by_name(row[3])
        # puts row[0]
      saving = TeacherClasse.new(user_id: current_teacher.id, salle_de_class_id: current_classe.id, matiere_id: current_matiere.id, structure_id: row[4])
      puts saving.save
    end
  end

  def class_with_initial
    "#{salle_de_class.name}"
  end

end
