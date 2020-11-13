class AddIsTroopToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :is_troop, :boolean, default: false, null: false
    add_column :activities, :is_pack, :boolean, default: false, null: false
  end
end
