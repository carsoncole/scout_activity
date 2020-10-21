class CreateTroops < ActiveRecord::Migration[6.0]
  def change
    create_table :troops do |t|
      t.string :unit_number
      t.boolean :is_polling_active, default: false
      t.integer :votes_allowed, default: 20, null: false

      t.timestamps
    end
  end
end
