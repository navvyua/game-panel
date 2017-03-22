class AddImageToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :post_image, :string
  end
end
