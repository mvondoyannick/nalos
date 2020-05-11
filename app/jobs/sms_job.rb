class SmsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Sms.send(phone: args[:phone], msg: args[:message])
  end
end
