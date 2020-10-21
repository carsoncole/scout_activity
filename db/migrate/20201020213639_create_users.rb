class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :cookie_id
      t.integer :votes_count

      t.timestamps
    end
  end
end
