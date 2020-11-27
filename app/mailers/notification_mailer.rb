class NotificationMailer < ApplicationMailer

  def new_notification_email
    mail(to: 'yannick.mvondo@paiemequick.com', subject: "Test rails mailer", body: "Si vous recever ce courriel c'est que la configuration c'est bien passsée!")
  end
end
