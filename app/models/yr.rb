class Yr < ApplicationRecord
  belongs_to :structure
  has_many :trs, dependent: :delete_all

  validates :debut, :end, :name, presence: true

  def trimestre_with_initial
    name.to_s
  end

end
