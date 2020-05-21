class Course < ApplicationRecord
  belongs_to :salle_de_class
  belongs_to :matiere
  belongs_to :user
  belongs_to :course_status
  has_one :document
  has_many :statistics

  #include sunspot
  # searchable do
  #   text :chapter
  # end
  validates :chapter, presence: true


  #set status
  before_save :set_status, if: :new_record?

  # send SMS after submit cours
  after_save :send_notification, if: :new_record? #:persisted?

  # including activeStorage
  has_one_attached :file
  has_rich_text :extrait

  private

  # send notification to admin that new course is been published
  def send_notification
    User.where(role_id: 2) do |admin|
      SmsJob.set(wait: 10.seconds).perform_later(691451189, msg: "#{current_user.complete_name} vient de publier une nouvelle leçon est #{self.chapter}. Ce cours est attente de validation.")
    end
  end

  # set course status
  def set_status
    self.course_status_id = CourseStatus.first.id
    self.token = SecureRandom.hex(12)
  end

end
