class AddUnitIdToUnitVotes < ActiveRecord::Migration[6.0]
  def change
    add_column :unit_votes, :unit_id, :integer
  end
end
