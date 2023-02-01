class CreateRecord < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.string :name
      t.string :address
      t.integer :age

      t.timestamps
    end
  end
end
