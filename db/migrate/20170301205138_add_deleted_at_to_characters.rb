class AddDeletedAtToCharacters < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :deleted_at, :datetime
    add_index :characters, :deleted_at
  end
end
