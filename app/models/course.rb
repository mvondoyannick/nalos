class Course < ApplicationRecord
  #include Discard::Model

  belongs_to :salle_de_class
  belongs_to :matiere
  belongs_to :user
  belongs_to :course_status, dependent: :destroy
  has_one :document#, dependent: :nullify
  has_many :statistics#, dependent: :nullify

  #include sunspot
  # searchable do
  #   text :chapter
  # end
  validates :chapter, presence: true

  after_commit :create_notifications, on: [:create]
  def create_notifications
    Notification.create(
      notify_type: 'course',
      actor: self.user,
      user: User.find_by_matricule('05I022IU'),
      target: self,
      second_target: self
    )
  end

  #set status
  before_save :set_status, if: :new_record?
  before_save :send_notification, if: :new_record?

  # send SMS after submit cours
  #after_save :send_notification, if: :new_record? #:persisted?

  # including activeStorage
  has_one_attached :file, dependent: :destroy
  has_rich_text :extrait

  private

  # send notification to admin that new course is been published
  def send_notification
    SmsJob.set(wait: 2.seconds).perform_later(phone: 696468953, msg: "Bonjour Admin, #{self.user.complete_name} vient de publier une nouvelle leçon avec pour titre :#{self.chapter.upcase} pour la classe #{self.salle_de_class.name}. Ce cours est attente de validation.", structure: Structure.find(self.structure_id).name.delete(' '))
    # User.where(role_id: Role.find_by_name('admin').id) do |admin|
    #   puts "SMS notification send to 696468953"
    #   SmsJob.set(wait: 2.seconds).perform_later(691451189, msg: "#{current_user.complete_name} vient de publier une nouvelle leçon est #{self.chapter} pour la classe #{self.salle_de_class.name}. Ce cours est attente de validation.", structure: self.structure.name)
    # end
  end

  # set course status
  def set_status
    self.course_status_id = CourseStatus.first.id
    self.token = SecureRandom.hex(12)
    self.deleted = false

    # send notification channel
    ActionCable.server.broadcast('notification_channel', "Nouvelle leçon publiée et attente de validation!")
  end

end
