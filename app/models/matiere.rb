class Matiere < ApplicationRecord
  has_many :courses
  has_many :teacher_classes
end
