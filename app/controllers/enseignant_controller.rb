class EnseignantController < ApplicationController
  before_action :authenticate_user!
  layout 'application'
  def index
  end

  def import
  end

  def list
  end

  def affectation
  end

  def statistic
  end
end
