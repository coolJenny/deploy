class AddpackcountToVendoritem < ActiveRecord::Migration[5.0]
  def change
    add_column :vendoritems, :packcount, :integer, default: 1
  end
end
