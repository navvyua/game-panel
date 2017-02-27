class CreateFactions < ActiveRecord::Migration[5.0]
  def change
    create_table :factions do |t|
      t.integer :type
      t.string :name

      t.timestamps
    end
  end
end
