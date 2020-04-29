class Matiere < ApplicationRecord
  has_many :courses
  has_many :teacher_classes

  # for epreuves
  has_many :epreuves
end
