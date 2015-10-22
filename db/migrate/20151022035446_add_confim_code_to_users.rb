class AddConfimCodeToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :confirm_code, :string
  end

  def down
  	remove_column :users, :confirm_code
  end
end
