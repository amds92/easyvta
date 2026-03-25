class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :slug
      t.string :tonearm_name
      t.text :description
      t.integer :price_pence
      t.string :shaft_size
      t.string :mounting_type
      t.integer :stock_status
      t.integer :position
      t.boolean :featured
      t.string :image_url
      t.text :notes

      t.timestamps
    end
  end
end
