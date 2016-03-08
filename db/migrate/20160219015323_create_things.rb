class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.integer :gateway_id
      t.integer :thing_type
      t.integer :thing_addr
      t.string :timestamp

      t.timestamps
    end
  end
end
