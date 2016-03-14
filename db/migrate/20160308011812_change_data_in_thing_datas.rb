class ChangeDataInThingDatas < ActiveRecord::Migration
  def change
	change_column :thing_data, :data, 'json USING CAST(data as json)'
  end
end
