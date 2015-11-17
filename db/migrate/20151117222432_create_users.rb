class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :provider
      t.string :uid
      t.string :password_digest
      t.string :last_access_ip
      t.datetime :last_access_at

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
