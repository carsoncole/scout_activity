class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.integer :unit_it
      t.string :mailer_instance
      t.string :message

      t.timestamps
    end
  end
end
