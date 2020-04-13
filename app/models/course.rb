class Course < ApplicationRecord
  belongs_to :salle_de_class
  belongs_to :matiere
  belongs_to :user
  belongs_to :course_status
  has_many :comments

  #include AlgoliaSearch

  #set status
  before_save :set_status

  # send SMS after submit cours
  after_save :send_notification

  # including activeStorage
  has_one_attached :file
  has_rich_text :extrait

  private
  def send_notification
    SendSms.send_sms
  end

  # set course status
  def set_status
    self.course_status_id = CourseStatus.first.id
  end
end
