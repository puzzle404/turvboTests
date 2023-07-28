class DropConvertation < ActiveRecord::Migration[7.0]
  def change
    drop_table :convertations
  end
end
