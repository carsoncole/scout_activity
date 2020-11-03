class AddIsUnsubscribedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_subscribed, :boolean, default: true, null: false
  end
end
