class RemoveUserFromVendoritem < ActiveRecord::Migration[5.0]
  def change
    remove_column :vendoritems, :user_id
  end
end
