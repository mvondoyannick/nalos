class SalleDeClass < ApplicationRecord
  has_many :students
  belongs_to :cycle_ecole
  belongs_to :structure
  has_many :users

  # for epreuves
  # has_many :epreuves

  before_create :generate_token

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      SalleDeClass.create! row.to_hash
    end
  end

  def self.import_data(file)
    CSV.foreach(file.path, headers: true) do |row|
      if SalleDeClass.exists?(name: row[0])
        puts "Enregistrement annulé"
      else
        save_data = SalleDeClass.new(name: row[0], effectif: nil, token: SecureRandom.hex(20), structure_id: Structure.find_by_name('GSBNAL').id, cycle_ecole_id: CycleEcole.first.id)
        if save_data.save
          puts "Salle de classe saved succefully"
        else
          puts "Cannot save salle de classe data : #{save_data.errors.details}"
        end
      end
    end
  end

  def salle_de_class_with_initial
      name.to_s
  end

  private
  def set_ecole_cycle
    self.cycle_ecole_id = 1
  end

  # generat salle de classe token
  def generate_token
    self.token = SecureRandom.hex(20)
  end
end
