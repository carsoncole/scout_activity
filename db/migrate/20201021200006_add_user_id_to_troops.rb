class AddUserIdToTroops < ActiveRecord::Migration[6.0]
  def change
    add_column :troops, :user_id, :integer
  end
end
