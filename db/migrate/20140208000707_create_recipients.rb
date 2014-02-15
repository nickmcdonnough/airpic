class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string :nickname
      t.string :full_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :lob_id
      t.integer :user_id

      t.timestamps
    end
  end
end
