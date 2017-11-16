class AddIndexToCompany < ActiveRecord::Migration[5.0]
  def change
    add_index :companies, :name,                unique: true
  end
end
