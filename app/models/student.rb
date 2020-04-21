class Student < ApplicationRecord
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
      Student.create! row.to_hash
    end
  end

  def complete_name
    "#{self.name} #{self.second_name}"
  end
end
