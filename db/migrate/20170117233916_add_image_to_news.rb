class AddImageToNews < ActiveRecord::Migration[5.0]
  def change
    add_column :news, :news_image, :string
  end
end
