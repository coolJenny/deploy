class AddOutputurlToSkynet < ActiveRecord::Migration[5.0]
  def change
    add_column :skynets, :outputfileurl, :string
  end
end
