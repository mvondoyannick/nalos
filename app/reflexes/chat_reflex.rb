# frozen_string_literal: true

class ChatReflex < ApplicationReflex
  include ActionView::Helpers::SanitizeHelper

  def post
    # morph :nothing

    input = element[:value]
    user = element.dataset[:teacher]
    student = element.dataset[:student]

    # create message
    @message = Message.new(user_id: 7, student_id: 1, subject: "vouala")
    @message.save
    #sub = element.dataset

    #chats = Rails.cache.read(:chats) || []
    #chats << chat
    #Rails.cache.write :chats, chats
  end

  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #   - params - parameters from the element's closest form (if any)
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

end
