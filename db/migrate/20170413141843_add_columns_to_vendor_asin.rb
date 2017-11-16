class AddColumnsToVendorAsin < ActiveRecord::Migration[5.0]
  def change
    add_column :vendorasins, :totalfbafee, :decimal, default: 0
    add_column :vendorasins, :mpn, :string, default: ''
    add_column :vendorasins, :ean, :string, default: ''
    add_column :vendorasins, :upc, :string, default: ''
    add_column :vendorasins, :salesrankcategory, :string, default: ''
    add_column :vendorasins, :invalidid, :boolean, default: false

    add_column :vendoritems, :vendorsku, :string, default: '', unique: true

    change_column :vendorasins, :buyboxprice, :decimal, default: 0
    change_column :vendoritems, :cost, :decimal, default: 0
  end
end
