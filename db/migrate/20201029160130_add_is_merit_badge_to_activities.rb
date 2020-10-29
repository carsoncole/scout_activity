class AddIsMeritBadgeToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :is_merit_badge, :boolean, default: false, null: false
  end
end
