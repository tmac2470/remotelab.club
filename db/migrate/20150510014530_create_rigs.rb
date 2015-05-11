class CreateRigs < ActiveRecord::Migration
  def change
    create_table :rigs do |t|
      t.string :title
      t.integer :rig_type
      t.integer :user_id
      t.text :description
      t.string :pdf_file

      t.timestamps
    end
  end
end
