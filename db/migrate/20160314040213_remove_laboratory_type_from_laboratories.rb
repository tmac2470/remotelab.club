class RemoveLaboratoryTypeFromLaboratories < ActiveRecord::Migration
  def change
    remove_column :laboratories, :laboratory_type, :integer
    remove_column :laboratories, :laboratory_hash, :character
  end
end
