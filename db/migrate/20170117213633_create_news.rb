class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :title
      t.text :text
      t.integer :user_id

      t.timestamps
    end
  end
end
