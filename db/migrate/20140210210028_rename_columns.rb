class RenameColumns < ActiveRecord::Migration
  def change
    rename_column :recipients, :address_line_1, :address_line1
    rename_column :recipients, :address_line_2, :address_line2
    rename_column :recipients, :zipcode, :zip
  end
end