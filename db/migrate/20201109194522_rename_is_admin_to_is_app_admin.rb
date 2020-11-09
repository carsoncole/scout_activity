class RenameIsAdminToIsAppAdmin < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :is_admin, :is_app_admin
  end
end
