class CreateVendoritems < ActiveRecord::Migration[5.0]
  def change
    create_table :vendoritems do |t|
      t.decimal :cost
      t.string :name
      t.references :vendorasin, index: true
      t.references :vendor, index: true
      t.references :user, index: true
      t.string  :asin
      t.string  :upc
      t.string  :isbn
      t.string  :ean
      t.timestamps
    end
  end
end
