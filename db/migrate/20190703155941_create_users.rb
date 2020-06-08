class CreateUsers < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!
  enable_extension 'citext'

  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.citext :email, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true, algorithm: :concurrently
  end
end
