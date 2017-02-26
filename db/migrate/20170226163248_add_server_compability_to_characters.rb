class AddServerCompabilityToCharacters < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :pos_x,        :float
    add_column :characters, :pos_y,        :float
    add_column :characters, :pos_z,        :float
    add_column :characters, :faction_id,   :integer, default: 0
    add_column :characters, :faction_role, :integer, default: 0
    add_column :characters, :faction_rank, :string
  end
end
