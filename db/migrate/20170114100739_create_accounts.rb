class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :uid
      t.string :provider
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
