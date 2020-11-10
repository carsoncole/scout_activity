class CreateNewsletters < ActiveRecord::Migration[6.0]
  def change
    create_table :newsletters do |t|
      t.string :date
      t.string :subject
      t.datetime :sent_at

      t.timestamps
    end
  end
end
