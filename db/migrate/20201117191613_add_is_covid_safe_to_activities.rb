class AddIsCovidSafeToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :is_covid_safe, :boolean, default: false, null: false
  end
end
