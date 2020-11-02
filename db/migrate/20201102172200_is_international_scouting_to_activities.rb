class IsInternationalScoutingToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :is_international_scouting, :boolean, default: false, null: false
  end
end
