class RemoveAuthorFromActivities < ActiveRecord::Migration[6.0]
  def change
    remove_column :activities, :author, :string
  end
end
