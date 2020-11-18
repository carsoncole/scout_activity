class ChangeColumnVotesCountOnActivities < ActiveRecord::Migration[6.0]
  def change
    change_column_default :activities, :votes_count, from: nil, to: 0
  end
end
