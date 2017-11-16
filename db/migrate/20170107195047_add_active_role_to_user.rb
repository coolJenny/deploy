class AddActiveRoleToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :active, :boolean, default: true
    add_reference :users, :Role, index: true
    add_reference :users, :Company, index: true
  end
end
