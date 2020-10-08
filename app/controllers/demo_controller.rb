class DemoController < ApplicationController
  def index
  end

  def form
  end

  # def auth user from token
  def token_auth
    if request.headers['HTTP_TOKEN'].present?
      # search student
      if User.exists?(token: request.headers['HTTP_TOKEN'])
        # search student by token
        c_user = User.find_by(request.headers['HTTP_TOKEN'])
        if c_user
          render json: {
            message: c_user.map do |data|
              {
                matricule: data.matricule,
                name: data.name,
                second_name: data.second_name,
                date_naissance: data.date_naissance,
                token: data.token,
                salle_de_class: data.salle_de_class.name,
                sexe: data.sexe,
                role: data.role.name,
                structure: data.structure.name
              }
            end
          }, status: :ok
        else
          render json: {
            message: "Utilisateur inconnu"
          }, status: :unauthorized
        end
      elsif Student.exists?(token: request.headers['HTTP_TOKEN'])
        # search user by token
        c_student = Student.find_by(token: request.headers['HTTP_TOKEN'])
        if c_student
          render json: {
            message: c_student.map do |data|
              {
                matricule: data.matricule,
                name: data.name,
                second_name: data.second_name,
                date_naissance: data.date_naissance,
                token: data.token,
                sexe: data.sexe,
                role: data.role.name,
                structure: data.structure.name
              }
            end
          }, status: :ok
        else
          render json: {
            message: "Utilisateur inconnu"
          }, status: :unauthorized
        end
      else
        render json: {
          status: 'Customer/user not found'
        }, status: :unauthorized
      end
    else
      render json: {
        status: "Impossible d'authentifier cet utilisateur, parametre manquant"
      }, status: :not_acceptable
    end
  end

  def fuse
    if params[:username].present? && params[:password].present?
      if User.exists?(matricule: params[:username].upcase)
        c_student = User.find_by(matricule: params[:username].upcase)
        if c_student&.valid_password?(params[:password])
          render json: {
            data: c_student,
            key: SecureRandom.uuid
          }, status: :ok
        else
          render json: {
            status: 'Compte ou mot de passe invalide'
          }, status: :unauthorized
        end
    else
      render json: {
        status: 'Student not found',
      }, status: :not_acceptable
      end
    else
      render json: {
        status: "Requete invalide!"
      }, status: :not_acceptable
    end 
  end

  # list last 10 teacher who have published some course
  def list_teacher
    last_teacher = User.where
    render json: User.last(10)
  end

  # get last course
  def list_last_course
    render json: Course.where(course_status_id: CourseStatus.find_by(name: 'waiting').id).as_json(only: [:chapter, :created_at, :token])
  end

  private
  def valid_credential
    params.permit(:username, :password)
  end
end
