class CreateSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers, id: false do |t|
      t.string :id
      t.string :name

      t.timestamps
    end
  end
end
