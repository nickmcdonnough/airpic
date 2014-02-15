class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :photo_url

      t.timestamps
    end
  end
end
