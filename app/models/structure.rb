class Structure < ApplicationRecord
  has_many :users
  has_many :cycle_ecoles
  has_many :salle_de_classes
  has_many :matieres
  # has_many :teacher_classes
  has_many :yrs, dependent: :delete_all

  validates :region, :pays, :logo, presence: {message: "%{value} est obligatoire."}
  validates :fixe, :name, :mobile, :email, presence: {message: '%{value} est obligatoire'}, uniqueness: {message: "%{value} à déja été utilisée."}

  has_one_attached :logo

  # trigger
  before_create :set_token, if: :new_record?

  private

  # generate auto token
  def set_token
    self.token = SecureRandom.hex(15)
  end

end
