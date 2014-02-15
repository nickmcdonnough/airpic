class FixColumnsCards < ActiveRecord::Migration
  def change
    add_column :cards, :photo_web_url, :string
  end
end
