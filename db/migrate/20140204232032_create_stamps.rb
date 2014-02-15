class CreateStamps < ActiveRecord::Migration
  def change
    create_table :stamps do |t|

      t.timestamps
    end
  end
end
