class CreateLaboratories < ActiveRecord::Migration
  def change
    create_table :laboratories do |t|
      t.string :title
      t.integer :laboratory_type
      t.integer :user_id
      t.text :description
      t.string :pdf_file
      t.text :ui_json
      t.string :laboratory_hash
      t.boolean :published
      t.string :password
      t.string :timestamp

      t.timestamps
    end
  end
end
