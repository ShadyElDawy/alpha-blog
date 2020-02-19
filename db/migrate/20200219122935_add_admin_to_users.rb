class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :admin, :boolean, default: false #setting an admin column to users table with default value of false
  end
end
