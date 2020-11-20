class Matiere < ApplicationRecord
  has_many :courses, dependent: :delete_all
  # has_many :teacher_classes
  belongs_to :structure
  belongs_to :filiere
  belongs_to :user

  before_create :set_token, if: :new_record?

  validates :name, presence: {message: "%{value} à deja été utilisé."}

  # for epreuves
  # has_many :epreuves

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Matiere.create!(row.to_hash)
    end
  end

  def matiere_with_initial
    name.to_s
  end

  private
  def set_token
    self.token = SecureRandom.hex(12)
  end
end
