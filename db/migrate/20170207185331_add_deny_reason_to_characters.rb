class AddDenyReasonToCharacters < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :deny_reason, :text
  end
end
