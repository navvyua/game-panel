class CreateBugTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :bug_tickets do |t|
      t.string :title
      t.string :description
      t.integer :user_id
      t.string :bug_image
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
