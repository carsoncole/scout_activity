class AddIsVirtualToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :is_virtual, :boolean, default: false, null: false
  end
end
