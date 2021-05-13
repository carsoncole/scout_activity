class AddExampleUnitVotesCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :example_unit_votes_count, :integer, default: 0, null: false
  end
end
