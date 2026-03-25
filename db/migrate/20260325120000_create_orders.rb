class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :reference, null: false
      t.string :customer_name, null: false
      t.string :customer_email, null: false
      t.string :customer_phone
      t.string :address_line1, null: false
      t.string :address_line2
      t.string :city, null: false
      t.string :postal_code, null: false
      t.string :country, null: false, default: "Portugal"
      t.text :customer_notes
      t.integer :status, null: false, default: 0
      t.integer :total_pence, null: false, default: 0
      t.timestamps
    end
    add_index :orders, :reference, unique: true
    add_index :orders, :customer_email
    add_index :orders, :status
  end
end
