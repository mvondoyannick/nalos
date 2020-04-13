class CreateLocalNews < ActiveRecord::Migration[6.0]
  def change
    create_table :local_news do |t|
      t.string :title
      t.string :extrait
      t.string :statut

      t.timestamps
    end
  end
end
