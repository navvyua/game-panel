class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.belongs_to :user, foreign_key: true
      t.text :description
      t.belongs_to :character, foreign_key: true
      t.json :images

      t.timestamps
    end
  end
end
