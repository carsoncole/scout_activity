class AddFundraisingCountToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :fundraising_count, :integer, default: 0, null: false
  end
end
