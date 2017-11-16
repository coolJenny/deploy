class CreateRakedCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :raked_categories do |t|
      t.string  :name
    end
    add_index :raked_categories, :name,                unique: true
  end
end
