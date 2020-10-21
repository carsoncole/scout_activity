class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :activity, null: false, foreign_key: true
      t.string :user_id
      t.timestamps
    end
  end
end
