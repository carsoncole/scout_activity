class ChangeColumnVotesCountOnUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :votes_count, from: nil, to: 0
  end
end
