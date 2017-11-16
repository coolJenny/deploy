class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.string :subscriptionid
      t.integer :amount
      t.string :interval
      t.integer :created
    end
    add_index :subscriptions, :subscriptionid, unique: true
  end
end
