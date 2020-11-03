class AddIsGameToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :is_game, :boolean, default: false, null: false
  end
end
