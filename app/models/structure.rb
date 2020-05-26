class Structure < ApplicationRecord
  has_many :users
  has_many :cycle_ecoles
  has_many :matieres

  validates :name, :email, :fixe, :mobile, :region, :pays, presence: true
end
