class CreateComponents < ActiveRecord::Migration[5.0]
  def change
    create_table :components do |t|
      t.integer :character_id
      t.integer :component
      t.integer :drawable, default: 0
      t.integer :texture,  default: 0
      t.integer :palette,  default: 0
    end
  end
end
