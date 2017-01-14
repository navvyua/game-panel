class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      # FOR DEVELOPMENT saves encrypted password in DB
      t.string :password_decrypted

      t.timestamps
    end
  end
end
