class AddoutputfileurlToSkynet < ActiveRecord::Migration[5.0]
  def change
    remove_column :skynets, :buyer_id
    add_column :skynets, :outputfileurl, :string
    add_reference :skynets, :user, index: true
  end
end
