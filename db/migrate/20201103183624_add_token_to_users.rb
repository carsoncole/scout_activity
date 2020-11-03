class AddTokenToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :token, :string
    User.all.each{|u| u.update(token: SecureRandom.hex)}
  end

  def down
    remove_column :users, :token
  end
end
