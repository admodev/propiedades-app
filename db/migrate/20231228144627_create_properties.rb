class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :type
      t.decimal :price
      t.string :currency
      t.string :commune
      t.string :address
      t.float :area
      t.integer :bedrooms
      t.integer :bathrooms
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
