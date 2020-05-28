class CycleEcole < ApplicationRecord
  belongs_to :structure
  has_many :users
  has_many :salle_de_classes

  def cycle_with_initial
    name.to_s
  end

end
