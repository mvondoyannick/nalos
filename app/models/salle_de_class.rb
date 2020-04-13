class SalleDeClass < ApplicationRecord
  has_many :students
  belongs_to :cycle_ecole
  has_many :users
end
