class ApplicationController < ActionController::Base

  skip_before_action :verify_authenticity_token
  # before_action :check_default_password
  # before_action :add_log if user_signed_in?
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :check_password
  before_action :redirect_user

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

  def redirect_user
    # def automatic redirection
    if user_signed_in?
      if current_user.role.name == "admin"
        admin_index_path
      else
        home_index_path
      end
    elsif student_signed_in?
      home_student_index_path
    end
  end

  # check user_student password
  def check_password
    if student_signed_in? && controller_name == "home_student"
      if current_student.valid_password?(123456)
        puts "you have to change password!"
        redirect_to edit_student_registration_path
      end
    elsif user_signed_in? && controller_name == "home"
      if current_user.valid_password?(123456)
        puts "Please update your password"
        redirect_to edit_user_registration_path
      end
    end
  end

  def configure_permitted_parameters
    added_attrs = [:matricule, :password, :remember_me]
    added_upt_ttrs = [:matricule, :email, :name, :second_name, :date_naissance, :lieu_naissance, :cni, :sexe]
    # devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, except: :password
  end

  # check if the user have default password
  def check_default_password
    if user_signed_in?
      if current_user.valid_password?("123456")
        # force to change password
        #redirect_to home_index_path, notice: "merci de me mettre votre mot de passe à jour", if: :course_controller
        @message_pwd = "lorem"
      else
        # password has been modified
      end
    elsif student_signed_in?
      if current_student.valid_password?("123456")
        # force user to change password
      else
        # password hab been modified
      end
    end
  end

  # save activity journal logs
  def add_log
    #permet de journaliser toutes les action dans la plateforme
    log = Journal.new
    log.browser = request.env['HTTP_USER_AGENT']
    #log.token = request.headers['HTTP_X_API_POP_KEY']
    log.ip = request.remote_ip #request.env['REMOTE_ADDR'] #request.remote_ip
    log.controller = params[:controller]
    log.action = params[:action]
    log.date = DateTime.now
    #log.pays = nil # DistanceMatrix::DistanceMatrix.pays(request.remote_ip)
    #log.region = nil # DistanceMatrix::DistanceMatrix.region(request.remote_ip)
    #log.user = current_member.email
    #log.role = current_member.service.name

    #on enregistre l'activité
    log.save
  end

end
