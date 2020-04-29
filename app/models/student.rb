class Student < ApplicationRecord
  # before_create :set_variable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :salle_de_class
  has_many :comments
  has_many :problemes
  has_many :messages
  # belongs_to :filiere

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Student.create!(row.to_hash)
    end
  end

  def complete_name
    "#{self.name} #{self.second_name}"
  end

  private

  def set_variable
    self.email = "#{Date.today.second}@nalos.com"
    self.password = 123456
    self.second_name = nil
    self.sexe = nil
    self.salle_de_class_id = 1
  end
end
