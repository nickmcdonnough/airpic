class AddUseridToStamps < ActiveRecord::Migration
  def change
    add_column :stamps, :user_id, :integer
  end
end
