class SalleDeClass < ApplicationRecord
  has_many :students
  belongs_to :cycle_ecole
  has_many :users

  # for epreuves
  has_many :epreuves

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      SalleDeClass.create! row.to_hash
    end
  end

  private
  def set_ecole_cycle
    self.cycle_ecole_id = 1
  end
end
