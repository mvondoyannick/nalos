class ApplicationController < ActionController::Base

  skip_before_action :verify_authenticity_token
  # before_action :configure_permitted_parameters, if: :devise_controller?

  puts "Aucune structure définie ..." if Structure.all.count.zero?

  def after_sign_in_path_for(user)
    if user_signed_in?
      if current_user.role.name == "teacher"
        home_index_path
      else
        admin_route_path
      end
    elsif student_signed_in?
      home_student_index_path
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:matricule, :password, :remember_me]
    # devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

end
