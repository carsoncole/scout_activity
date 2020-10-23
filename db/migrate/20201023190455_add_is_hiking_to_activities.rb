class AddIsHikingToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :is_hiking, :boolean, default: false, null: false
    add_column :activities, :is_camping, :boolean, default: false, null: false
    add_column :activities, :is_swimming, :boolean, default: false, null: false
    add_column :activities, :is_plane, :boolean, default: false, null: false
  end
end
