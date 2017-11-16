class CreateProductGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :product_groups do |t|
      t.string  :name
    end
    add_index :product_groups, :name,                unique: true
  end
end
