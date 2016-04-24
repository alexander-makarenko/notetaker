class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.datetime :birthdate
      t.string :phone
      t.string :password_digest
      t.string :auth_digest

      t.timestamps null: false
    end
    add_index :users, :login, unique: true
    add_index :users, :email, unique: true
    add_index :users, :auth_digest, unique: true
  end
end
