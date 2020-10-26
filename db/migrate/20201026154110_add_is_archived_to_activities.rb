class AddIsArchivedToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :is_archived, :boolean, default: false, null: false
  end
end
