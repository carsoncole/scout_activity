class AddCovidSafeCountToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :covid_safe_count, :integer, default: 0, null: false
    add_column :units, :troop_count, :integer, default: 0, null: false
  end
end
