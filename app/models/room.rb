class Room < ApplicationRecord
  before_create do
    opentok = OpenTok::OpenTok.new  "47009224", '6f69d24bc9a24359038b2af9323f7a80cb3739ae', :timeout_length => 30
    session = opentok.create_session
    self.vonage_session_id = session.session_id
  end
  belongs_to :user
  belongs_to :salle_de_class
  belongs_to :filiere

  validates :name, presence: true
end
