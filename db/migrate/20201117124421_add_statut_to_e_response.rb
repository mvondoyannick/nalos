class AddStatutToEResponse < ActiveRecord::Migration[6.0]
  def change
    add_column :e_responses, :statut, :boolean
    add_column :e_responses, :description, :string
  end
end
