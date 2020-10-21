class AddVotesCountToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :votes_count, :integer
  end
end
