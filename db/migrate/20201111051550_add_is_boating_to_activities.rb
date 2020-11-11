class AddIsBoatingToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :is_boating, :boolean, default: false, null: false
  end
end
