class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:matricule]

  before_create :set_user_token, if: :new_record?

  #validates :name, :password, :structure_id, :salle_de_class_id, :cycle_ecole_id, :cni, :role_id, :sexe, presence: {message: "%{value} est obligatoire, merci de le renseigner."}
  #validates :name, :matricule, :email, :cni, :phone1, :phone2, presence: {message: "Champs obligatoire manquant"}, uniqueness: {message: "%{value} à déja été utilisé"}

  belongs_to :role
  belongs_to :structure
  belongs_to :cycle_ecole
  has_many :courses
  has_many :comments
  has_many :messages
  has_many :blogs

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

  private

  # set user token and statut
  def set_user_token
    self.token = SecureRandom.hex(20)
    self.statut = "active"
  end
end
