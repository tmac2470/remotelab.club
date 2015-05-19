class AddAttributesToRigs < ActiveRecord::Migration
  def change
    add_column :rigs, :published, :boolean, default: false
    add_column :rigs, :password, :string
  end
end
