class AddTroopToActivities < ActiveRecord::Migration[6.0]
  def change
    add_reference :activities, :troop, null: false, foreign_key: true
  end
end
