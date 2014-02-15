class AddOrderColumns < ActiveRecord::Migration
  def change
    add_column :orders, :photo_pdf_url, :string
    add_column :orders, :photo_web_url, :string

    #remove_column :cards, :photo_pdf_url, :string
    #remove_column :cards, :photo_pdf_url, :string
  end
end
