class RenameColumnUserIdToAuthorId < ActiveRecord::Migration[6.0]
  def change
    rename_column :activities, :user_id, :author_id
  end
end
