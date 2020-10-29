class AddIsFundraisingToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :is_fundraising, :boolean, default: false, null: false
  end
end
