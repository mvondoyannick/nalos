class Course < ApplicationRecord
  belongs_to :salle_de_class
  belongs_to :matiere
  belongs_to :user
  belongs_to :course_status
  has_one :document

  #include sunspot
  searchable do
    text :chapter
  end


  #set status
  before_save :set_status, if: :new_record?

  # send SMS after submit cours
  after_save :sms_notification, if: :persisted?

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

  # send sms after publish course
  def sms_notification
    current_class = salle_de_class_id
    # begin extract data
    Student.where(salle_de_class_id: current_class).each do |the_student|
      Sms.send(
          phone: the_student.phone,
          msg: "Bonjour Mr/Mme #{the_student.complete_name.upcase}, un nouveau cours de #{matiere.name}, titre : #{chapter.upcase} vient d'etre publié par Mr/Mme #{User.find(user_id).complete_name}"
      )
    end
  end
end
