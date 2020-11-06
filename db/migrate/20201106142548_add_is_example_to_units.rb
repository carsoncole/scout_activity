class AddIsExampleToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :is_example, :boolean, default: false, null: false
  end
end
