module ApplicationHelper
  def lorem(user)
      @current_structure = Structure.find(user.structure_id)
      render partial: 'layouts/logo_type'
  end
end
