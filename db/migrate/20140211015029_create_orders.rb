class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :lob_id
      t.integer :date
      t.string :photo_url

      t.timestamps
    end
  end
end
