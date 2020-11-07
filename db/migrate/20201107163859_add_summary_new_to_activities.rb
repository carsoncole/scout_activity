class AddSummaryNewToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :summary_new, :string
  end
end
