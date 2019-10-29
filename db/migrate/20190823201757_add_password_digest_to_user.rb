class AddPasswordDigestToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :password_digest
      t.string :email
    end
  end
end
