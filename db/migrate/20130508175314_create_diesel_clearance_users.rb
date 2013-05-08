class CreateDieselClearanceUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.string   :email
      t.string   :encrypted_password, :limit => 128
      t.string   :salt,               :limit => 128
      t.string   :confirmation_token, :limit => 128
      t.string   :remember_token,     :limit => 128
    end

    add_index :users, :email
    add_index :users, :remember_token
  end
end
