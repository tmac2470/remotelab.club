class CreateGateways < ActiveRecord::Migration
  def change
    create_table :gateways do |t|
      t.boolean :synched
      t.string :password
      t.string :timestamp

      t.timestamps
    end
  end
end
