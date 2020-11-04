class ChangeColumnUser < ActiveRecord::Migration[6.0]
  def up
    change_column :votes, :user_id, 'integer USING CAST(user_id AS integer)'
  end

  def down
    change_column :votes, :user_id, :string
  end
end
