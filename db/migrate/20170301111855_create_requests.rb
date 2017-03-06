class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.text :description
      t.boolean :closed,  default: false
      t.belongs_to :user, foreign_key: true
      t.belongs_to :admin
      t.timestamps
    end
  end
end
