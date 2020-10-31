class AddIsOwnerToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :is_owner, :boolean, default: false, null: false

    Troop.all.each do |troop|
      User.find(troop.user_id).update(is_owner: true)
    end
  end

  def down
    remove_column :users, :is_owner
  end
end
