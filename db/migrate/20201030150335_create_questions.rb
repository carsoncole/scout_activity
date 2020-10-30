class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :activity, null: false, foreign_key: true
      t.string :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
