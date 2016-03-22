class ChangeColumnTopicInThingLogs < ActiveRecord::Migration
  def change
	add_index :thing_logs, :topic	
  end
end
