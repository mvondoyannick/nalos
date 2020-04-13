class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role
  belongs_to :structure
  belongs_to :cycle_ecole
  has_many :courses
  has_one :salle_de_class

  def complete_name
    "#{self.name} " + "#{self.second_name}"
  end
end
