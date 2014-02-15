class AddAttsToStamps < ActiveRecord::Migration
  def change
    add_column :stamps, :quantity, :integer
    add_column :stamps, :date, :integer
    add_column :stamps, :notes, :string
  end
end
