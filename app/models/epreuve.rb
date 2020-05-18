class Epreuve < ApplicationRecord

  before_save :generate_token, if: :new_record?

  belongs_to :salle_de_class
  belongs_to :matiere
  belongs_to :user

  # enable activeStorage
  has_one_attached :file
  has_one_attached :response

  # validation
  validates :file, :response, presence: true
  validates :title, presence: true

  private

  def compare
    puts FileUtils.compare_file(file, response)
  end

  # generate token
  def generate_token
    self.token = SecureRandom.hex(10)
  end

end
