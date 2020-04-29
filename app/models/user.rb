class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role
  belongs_to :structure
  belongs_to :cycle_ecole
  has_many :courses
  has_many :comments
  has_many :messages

  # for epreuve
  has_many :epreuves

  # has_many :documents
  has_one :salle_de_class

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      User.create! row.to_hash
    end
  end

  def complete_name
    "#{self.name} " + "#{self.second_name}"
  end
end
