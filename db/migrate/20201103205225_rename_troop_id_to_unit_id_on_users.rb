class RenameTroopIdToUnitIdOnUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :troop_id, :unit_id
  end
end
