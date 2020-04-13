class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :salle_de_class
  # belongs_to :filiere

  def complete_name
    "#{self.name} #{self.second_name}"
  end
end
