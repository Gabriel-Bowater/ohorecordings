class ChangeUserEmailConfirmedDefaultToFalse < ActiveRecord::Migration
  def up
  	change_column_default :users, :email_confirmed, false
  end

  def down
  	change_column_default :users, :email_confirmed, true
  end
end
