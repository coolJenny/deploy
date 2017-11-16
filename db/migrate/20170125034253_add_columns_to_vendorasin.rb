class AddColumnsToVendorasin < ActiveRecord::Migration[5.0]
  def change
    add_reference :vendorasins, :product_groups, index: true
    add_column :vendorasins, :packagewidth, :decimal
    add_column :vendorasins, :packageheight, :decimal
    add_column :vendorasins, :packagelength, :decimal
    add_column :vendorasins, :packageweight, :decimal
    add_column :vendorasins, :notes, :string
    add_column :vendorasins, :review, :decimal, default: 0
    add_column :vendorasins, :numreview, :integer, default: 0
    remove_column :vendorasins, :amazonoffer
    add_column :vendorasins, :amazonoffer, :boolean, default: false
  end
end
