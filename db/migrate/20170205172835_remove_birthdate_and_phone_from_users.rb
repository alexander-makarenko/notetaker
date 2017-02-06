class RemoveBirthdateAndPhoneFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :birthdate, :string
    remove_column :users, :phone, :string
  end
end
