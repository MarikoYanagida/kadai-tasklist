class AddUserToTasklists < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasklists, :user, foreign_key: true
  end
end
