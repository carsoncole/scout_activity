class RemoveColumnCookieIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :cookie_id, :string
  end
end
