class RenameTroopIdToUnitIdOnActivities < ActiveRecord::Migration[6.0]
  def change
    rename_column :activities, :troop_id, :unit_id
  end
end
