class AddTopicToThingData < ActiveRecord::Migration
  def change
    add_column :thing_data, :topic, :string
  end
end
