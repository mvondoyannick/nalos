# frozen_string_literal: true

class ExampleReflex < ApplicationReflex

  def greetings
    content = Role.find(element.dataset[:id])
    @data = content.created_at
  end

  # soft role delete
  def delete_role
    role = Role.find(element.dataset[:id])
    if role.name == "admin" || role.name == "root" || role.name == "teacher"
      puts "Impossible de supprimer #{role.name}"
    else
      role.delete

      #send mail to notify that role has been deleted
      NotificationMailer.new_notification_email.deliver_now

    end
    # deleted = role.delete
  end

  #update course and notified teacher with email and SMS
  def update_course
    if element.dataset[:name] == "waiting"
      course = Course.find(element.dataset[:id])
      course.update(course_status_id: CourseStatus.find_by_name('validate').id)
    else
      #course = Course.find(element.dataset[:id])
      #course.update(course_status_id: CourseStatus.find_by_name('validate').id)
      # flash.now[:notice] = 'Message sent!'
      # flash.now[:error] = "Could not save client"
    end
  end

  # suspendre des cours
  def suspend_course
    if element.dataset[:name] == "validate"
      course = Course.find(element.dataset[:id])
      course.update(course_status_id: CourseStatus.find_by_name('waiting').id)
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
