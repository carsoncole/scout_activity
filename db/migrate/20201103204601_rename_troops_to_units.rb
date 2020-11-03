class RenameTroopsToUnits < ActiveRecord::Migration[6.0]
  def change
    rename_table :troops, :units
  end
end
