class Matiere < ApplicationRecord
  has_many :courses
  has_many :teacher_classes

  # for epreuves
  has_many :epreuves

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Matiere.create!(row.to_hash)
    end
  end
end
