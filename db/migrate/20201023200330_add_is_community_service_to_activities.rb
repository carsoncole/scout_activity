class AddIsCommunityServiceToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :is_community_service, :boolean, default: false, null: false
  end
end
