  class DropTableNews < ActiveRecord::Migration[5.0]
  def change
    drop_table :news
  end
end
