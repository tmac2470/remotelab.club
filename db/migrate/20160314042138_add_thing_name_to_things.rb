class AddThingNameToThings < ActiveRecord::Migration
  def change
    add_column :things, :thing_name, :string
  end
end
