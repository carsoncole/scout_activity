class AddSlugToTroops < ActiveRecord::Migration[6.0]
  def change
    add_column :troops, :slug, :string
    add_index :troops, :slug, unique: true
  end
end
