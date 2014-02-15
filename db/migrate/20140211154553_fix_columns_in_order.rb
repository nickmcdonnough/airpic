class FixColumnsInOrder < ActiveRecord::Migration
  def change
    rename_column :orders, :lob_id, :lob_address_id
    rename_column :orders, :photo_url, :lob_job_id
    remove_column :orders, :date
  end
end
