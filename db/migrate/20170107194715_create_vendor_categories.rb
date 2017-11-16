class CreateVendorCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :vendor_categories do |t|
      t.string :name, null: false
    end

    add_index :vendor_categories, :name, unique: true
  end
end
