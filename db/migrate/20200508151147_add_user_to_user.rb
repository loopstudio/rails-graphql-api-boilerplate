class AddUserToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :user, foreign_key: true
  end
end
