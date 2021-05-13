class RenameTableVotesToUnitVotes < ActiveRecord::Migration[6.0]
  def change
    rename_table :votes, :unit_votes
    rename_column :activities, :votes_count, :unit_votes_count
    rename_column :users, :votes_count, :unit_votes_count
  end
end
