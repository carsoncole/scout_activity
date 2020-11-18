class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :author
      t.string :duration_days, default: 1
      t.boolean :is_high_adventure, default: false, null: false
      t.boolean :is_author_volunteering, default: false, null: false

      t.timestamps
    end
  end
end
