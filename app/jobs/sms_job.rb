class SmsJob < ApplicationJob
  queue_as :default

  retry_on Timeout::Error, wait: 10.seconds, attempts: 3
  retry_on StandardError, wait: 10.seconds, attempts: 3

  rescue_from(StandardError) do |exception|
    # Do something with the exception
    Sms.send(phone: 691541189, msg: "Impossible de renvoyer le sms. Error : #{exception}")
  end

  def perform(args)
    # Do something later
    # structure = current_structure(current_user.structure.name.delete(' ').upcase)
    Sms.send(phone: args[:phone], msg: args[:msg], structure: args[:structure].delete(' '))
  end
end
