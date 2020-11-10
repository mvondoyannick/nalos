class Role < ApplicationRecord
  has_many :users

  def role_with_initial
    name.to_s.upcase
  end

end
