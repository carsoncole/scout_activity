class RemoveColumnUserIdFromUnits < ActiveRecord::Migration[6.0]
  def change
    remove_column :units, :user_id, :integer
  end
end
