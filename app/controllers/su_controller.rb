class SuController < ApplicationController

  def index
  end

  def etablissements
    @structures = Structure.all
  end
end
