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
        c_teacher = User.find_by(matricule: params[:username].upcase)
        if c_teacher&.valid_password?(params[:password])
          render json: {
              data: {
                  email: c_teacher.email,
                  name: c_teacher.name,
                  second_name: c_teacher.second_name,
                  matricule: c_teacher.matricule,
                  etablissement: c_teacher.structure.name,
                  role: "teacher"
              },
              key: c_teacher.token
          }, status: :ok
        else
          render json: {
              status: 'Compte ou mot de passe invalide'
          }, status: :unauthorized
        end
      elsif Student.exists?(matricule: params[:username].upcase)
        c_students = Student.find_by(matricule: params[:username].upcase)
        if c_students&.valid_password?(params[:password])
          render json: {
              data: {
                  email: c_students.email,
                  name: c_students.name,
                  second_name: c_students.second_name,
                  phone: c_students.phone,
                  matricule: c_students.matricule,
                  salle_de_class: c_students.salle_de_class.name,
                  etablissement: Structure.find(c_students.structure).name,
                  role: "student"
              },
              key: c_students.token
          }, status: :ok
        else
          render json: {
              status: 'Compte ou tulisateur inconnu',
          }, status: :not_acceptable
        end
      end
    else
      render json: {
          status: "Requete invalide!"
      }, status: :not_acceptable
    end
  end

  # verififier un utilisateur sur la base de sont token
  def auth_user_by_token

    if params[:token].present?
      key = params[:token]
      if User.exists?(token: params[:token])
        c_teacher = User.find_by(token: params[:token])
        if c_teacher
          render json: {
              data: {
                  email: c_teacher.email,
                  name: c_teacher.name,
                  second_name: c_teacher.second_name,
                  matricule: c_teacher.matricule,
                  etablissement: c_teacher.structure.name,
                  role: "teacher"
              },
              key: c_teacher.token
          }, status: :ok
        else
          render json: {
              status: 'Compte ou mot de passe invalide'
          }, status: :unauthorized
        end
      elsif Student.exists?(token: params[:token])
        c_students = Student.find_by(token: params[:token])
        if c_students
          render json: {
              data: {
                  email: c_students.email,
                  name: c_students.name,
                  second_name: c_students.second_name,
                  phone: c_students.phone,
                  matricule: c_students.matricule,
                  salle_de_class: c_students.salle_de_class.name,
                  etablissement: Structure.find(c_students.structure).name,
                  role: "student"
              },
              key: c_students.token
          }, status: :ok
        else
          render json: {
              status: 'Compte ou tulisateur inconnu',
          }, status: :unauthorized
        end
      end
    else
      render json: {
          status: "Compte ou utilsateur invalide"
      }, status: :unauthorized
    end

  end

  # create student account
  def new_student
    if params[:email].present? && params[:name].present? && params[:phone].present? && params[:matricule].present? && params[:etablissement]

      # begin create new student account
      new_student_account = Student.new(
          email: params[:email],
          name: params[:name],
          second_name: params[:second_name],
          sexe: params[:sexe],
          phone: params[:phone],
          matricule: params[:matricule],
          structure: params[:structure],
          salle_de_classes: "lorem",
          filiere: "filiere lorem")

      # validate data
      if new_student_account.valid?

        # begin saving data ton DB
        if new_student_account.save

          # send SMS Noitification
          # respond to app client
          render json: {
              message: "le compte #{params[:email]} à été correctement crée. Merci de vous connecter."
          }, status: :created

        else

          render json: {
              message: "Impossible de terminer la création de votre compte : #{new_student_account.errors.messages}"
          }, status: :unauthorized

        end

      else
        render json: {
            message: "Données fournis invalide"
        }, status: :bad_request
      end

    else
      render json: {
          message: "Parametres invalides ou manquant"
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
