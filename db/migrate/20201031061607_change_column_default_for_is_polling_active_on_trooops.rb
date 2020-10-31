class ChangeColumnDefaultForIsPollingActiveOnTrooops < ActiveRecord::Migration[6.0]
  def change
    change_column_default :troops, :is_polling_active, from: false, to: true
  end
end
