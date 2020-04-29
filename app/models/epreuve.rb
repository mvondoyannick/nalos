class Epreuve < ApplicationRecord

  # before_validation :compare

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

end
