class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products, id: false do |t|
      t.string :id, primary_key: true
      t.string :supplier_id, foreign_key: true
      t.string :field1
      t.string :field2
      t.string :field3
      t.string :field4
      t.string :field5
      t.string :field6
      t.decimal :price

      t.timestamps
    end
  end
end
