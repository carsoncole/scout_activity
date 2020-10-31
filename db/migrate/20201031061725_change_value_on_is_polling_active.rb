class ChangeValueOnIsPollingActive < ActiveRecord::Migration[6.0]
  def up
    Troop.update_all(is_polling_active: true)
  end
end
