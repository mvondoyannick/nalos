class ExtractName
  def self.extract_first_letter(name)
    @name = name
    current_name = @name.split(" ")
    if current_name.count >= 2
      first_letter = current_name.first[0].upcase
      last_letter = current_name.last[0].upcase
      return "#{first_letter}#{last_letter}"
    elsif current_name.count == 1
      first_letter = current_name.first[0..1].upcase
      return first_letter
    end
  end

  # return extention

  #extract content type from ActiveStorage and return thumbnali
  # @param content_type
  # @return fileextention
  def self.extract_content_type(content_type)
    require 'action_view'
    @content_type = content_type
    current_content_type = @content_type.split("/")
    if current_content_type.count > 2
      # return default image PNG
      return Rails.root.join("app", "assets", "images", "course.png").to_s
    elsif current_content_type.count == 2
      last_content_type = current_content_type.last
      case last_content_type
        when "mp4"
          return "video.png"
        when "ogg"
          return "video.png"
        when "pdf"
          return "pdf.png"
        when "mp3"
          return "audio.png"
        when "png"
          return "photo.png"
        else
          return "document.png"
      end
    else
      if "document".in? current_content_type
        puts current_content_type
        return "word.png"
      elsif "sheet".in? current_content_type
        return  "excel.png"
      end
    end
  end
end