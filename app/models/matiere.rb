class Matiere < ApplicationRecord
  has_many :courses
  has_many :teacher_classes

  before_create :set_token, if: :new_record?

  # for epreuves
  has_many :epreuves

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Matiere.create!(row.to_hash)
    end
  end

  private
  def set_token
    self.token = SecureRandom.hex(12)
  end
end
