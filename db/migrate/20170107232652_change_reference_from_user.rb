class ChangeReferenceFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :Role_id
    remove_column :users, :Company_id
    add_reference :users, :role, index: true
    add_reference :users, :company, index: true
  end
end
