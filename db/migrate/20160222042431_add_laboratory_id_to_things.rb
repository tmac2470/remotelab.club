class AddLaboratoryIdToThings < ActiveRecord::Migration
  def change
    add_column :things, :laboratory_id, :integer
  end
end
