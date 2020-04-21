class ManageCourse

  def self.save_course(argv)
    argv = argv
    puts argv
    current_course = Course.new(argv)
    if current_course.save
      return true, "saved"
    else
      return false, current_course.errors.details
    end
  end

end