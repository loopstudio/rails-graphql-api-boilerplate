class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :field_name

      t.timestamps
    end
  end
end
