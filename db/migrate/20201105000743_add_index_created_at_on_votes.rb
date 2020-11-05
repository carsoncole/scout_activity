class AddIndexCreatedAtOnVotes < ActiveRecord::Migration[6.0]
  def change
    add_index :votes, :created_at
  end
end
