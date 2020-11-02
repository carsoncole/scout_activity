class AddIndexVisitEventCountOnTroops < ActiveRecord::Migration[6.0]
  def change
    add_index :troops, :visit_event_count
  end
end
