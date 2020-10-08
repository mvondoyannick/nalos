class Tr < ApplicationRecord
  belongs_to :yr

  def trimestre_with_initial
    name.to_s
  end

end
