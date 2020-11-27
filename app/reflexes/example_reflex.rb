# frozen_string_literal: true

class ExampleReflex < ApplicationReflex

  def greetings
    content = Role.find(element.dataset[:id])
    @data = content.created_at
  end

  #update course and notified teacher with email and SMS
  def update_course
    if element.dataset[:name] == "validate"
      flash.now[:notice] = 'Message sent!'
      # flash.now[:error] = "Could not save client"
    else
      course = Course.find(element.dataset[:id])
    end
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
