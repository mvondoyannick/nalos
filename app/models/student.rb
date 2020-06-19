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

  def self.import_bak(file)
    CSV.foreach(file.path, headers: true) do |row|
      Student.create!(row.to_hash)
    end
  end

  def self.import(file)
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
