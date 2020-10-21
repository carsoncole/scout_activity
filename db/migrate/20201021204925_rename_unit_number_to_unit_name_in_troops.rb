class RenameUnitNumberToUnitNameInTroops < ActiveRecord::Migration[6.0]
  def change
    rename_column :troops, :unit_number, :unit_name
  end
end
