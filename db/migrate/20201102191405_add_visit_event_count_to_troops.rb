class AddVisitEventCountToTroops < ActiveRecord::Migration[6.0]
  def change
    add_column :troops, :visit_event_count, :integer, default: 0
  end
end
