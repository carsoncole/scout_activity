class RenameColumnUnitNameToNameOnTroops < ActiveRecord::Migration[6.0]
  def change
    rename_column :troops, :unit_name, :name
  end
end
