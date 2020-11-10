class JfnController < ApplicationController
  layout 'application_new'
  def index
  end

  def admin_index
  end

  def auth_teachers
    if params[:email].present? && params[:password].present?
      if User.exists?(email: params[:email], role_id: Role.find_by_name('jfn').id, is_jfn: true)
        render json: {
            message: "Authenticated"
        }, status: :ok
      else
        render json: {
            message: ""
        }, status: :unauthorized
      end
    else
      render json: {
          message: "Parametres invalides/Missing parameters"
      }, status: :bad_request
    end
  end
end
