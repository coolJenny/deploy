class CreateVendorasins < ActiveRecord::Migration[5.0]
  def change
    create_table :vendorasins do |t|
      t.string  :asin
      t.references :brand, index: true
      t.string  :name
      t.integer :salesrank
      t.integer :packagequantity
      t.decimal :buyboxprice
      t.decimal :referenceoffer
      t.string  :referenceoffertype
      t.integer :amazonoffer
      t.decimal :fbafee
      t.decimal :storagefee
      t.decimal :variableclosingfee
      t.decimal :commissionpct
      t.decimal :commissiionfee
      t.decimal :inboundshipping
      t.decimal :profit
      t.integer :salespermonth
      t.integer :totaloffers
      t.integer :fbaoffers
      t.integer :fbmoffers
      t.decimal :lowestfbaoffer
      t.decimal :lowestfbmoffer
      t.boolean :isbuyboxfba
      t.references  :product_type, index: true
      t.references  :ranked_category, index: true
      t.decimal :weight
      t.decimal :length
      t.decimal :width
      t.decimal :height
      t.timestamps
    end
    add_index :vendorasins, :asin,                unique: true
  end
end
