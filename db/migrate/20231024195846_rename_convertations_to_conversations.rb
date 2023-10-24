class RenameConvertationsToConversations < ActiveRecord::Migration[7.0]
  def change
    rename_table :conversations, :convertations
  end
end
