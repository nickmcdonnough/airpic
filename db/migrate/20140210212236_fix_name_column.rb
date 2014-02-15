class FixNameColumn < ActiveRecord::Migration
  def change
    rename_column :recipients, :full_name, :name
  end
end
