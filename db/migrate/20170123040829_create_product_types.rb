class CreateProductTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :product_types do |t|
      t.string  :name
    end
    add_index :product_types, :name,                unique: true
  end
end
