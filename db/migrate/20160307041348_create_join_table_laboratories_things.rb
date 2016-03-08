class CreateJoinTableLaboratoriesThings < ActiveRecord::Migration
  def change
    create_join_table :laboratories, :things do |t|
      # t.index [:laboratory_id, :thing_id]
      # t.index [:thing_id, :laboratory_id]
    end
  end
end
