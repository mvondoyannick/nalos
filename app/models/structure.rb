class Structure < ApplicationRecord
  has_many :users
  has_many :cycle_ecoles
  has_many :salle_de_classes
  has_many :matieres
  has_many :filieres
  has_many :courses
  # has_many :teacher_classes
  has_many :yrs, dependent: :delete_all
  belongs_to :structure_type
  has_many :documents

  validates :region, :pays, :logo, presence: {message: "%{value} est obligatoire."}
  validates :fixe, :name, :mobile, :email, presence: {message: '%{value} est obligatoire'}, uniqueness: {message: "%{value} à déja été utilisée."}

  has_one_attached :logo
  has_one_attached :rccm

  # trigger
  before_create :set_token, if: :new_record?

  def structure_with_initial
    name.to_s.upcase
  end

  private

  # generate auto token
  def set_token
    self.token = SecureRandom.hex(15)
  end

end
