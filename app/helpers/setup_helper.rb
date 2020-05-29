module SetupHelper

  def current_structure(structure_token)
    @structure = Structure.find_by_token(structure_token)
  end

end
