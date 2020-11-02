class RenameColumnIsInternationalScoutingToIsInternational < ActiveRecord::Migration[6.0]
  def change
    rename_column :activities, :is_international_scouting, :is_international
  end
end
