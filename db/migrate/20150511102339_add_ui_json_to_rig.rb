class AddUiJsonToRig < ActiveRecord::Migration
  def change
    add_column :rigs, :ui_json, :text
  end
end
