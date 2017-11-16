class AddStatusToSkynet < ActiveRecord::Migration[5.0]
  def change
    add_column :skynets, :statusmessage, :string
    add_reference :skynets, :skynet_status, index: true
  end
end
