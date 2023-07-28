class CreateConvertations < ActiveRecord::Migration[7.0]
  def change
    create_table :convertations do |t|
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
