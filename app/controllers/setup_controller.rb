class SetupController < ApplicationController

  before_action :authenticate_user!

  # index of setup plateforme
  def index
  end

  def enseignant_index
    @enseignants = User.where(role_id: 1).where(structure_id: 1).page(params[:page]).per(12)
  end

  def student_index
  end

  def notification_index
  end

  def course_index
  end

  def droits_index

  end

  def structure_index

  end
end
