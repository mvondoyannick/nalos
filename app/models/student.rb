class Student < ApplicationRecord
  # before_create :set_variable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:matricule]

  belongs_to :salle_de_class
  has_many :comments
  has_many :problemes
  has_many :messages
  # belongs_to :filiere
  has_many :e_responses, dependent: :delete_all

  def self.import_bak(file)
    CSV.foreach(file.path, headers: true) do |row|
      Student.create!(row.to_hash)
    end
  end

  def self.import_bak_1(file)
    CSV.foreach(file.path, headers: true) do |row|
      if Student.exists?(matricule: row[1])

        c_student = Student.find_by(matricule: row[1])

        # Extract salle de classe id
        if SalleDeClass.exists?(name: row[0])

          c_classe = SalleDeClass.find_by_name(row[0])

          # update student classe
          if c_student.update(sexe: row[3], salle_de_class_id: c_classe.id)

            puts "#{c_student.complete_name} Updated"

          else

            puts "Mise à jour de #{c_student.complete_name} impossible"

          end

        else

          puts "Creation de cette nouvelle salle de classe"

        end

      end
    end
  end


  # update and extend student model
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      if Student.exists?(matricule: row[0])
        c_student = Student.find_by_matricule(row[0])
        if c_student.update(pere: row[1], mere: row[2], c_pere: row[3], f_pere: row[4], c_mere: row[5], f_mere: row[6], c_tuteur: row[7], c_autre: row[8])
          puts "Student #{c_student.complete_name} updated"
        else
          puts "Impossible de faire la mise à jour."
        end
      else
        puts "etudiant inconnu #{row[0]}"
      end
    end
  end

  def complete_name
    "#{self.name} #{self.second_name}"
  end

  private

  def set_variable
    self.email = "#{Date.today.second}@nalos.com"
    self.password = 123456
    self.second_name = nil
    self.sexe = nil
    self.salle_de_class_id = 1
  end
end
