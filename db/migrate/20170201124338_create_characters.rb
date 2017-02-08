class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string  :first_name
      t.string  :last_name
      t.integer :age
      t.text    :biography
      t.integer :status,  default: 0
      t.integer :cash,    default: 500
      t.integer :bank,    default: 2000
      t.boolean :driving_license
      t.string  :faction, default: 'Civilian'
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
