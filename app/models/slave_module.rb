class SlaveModule < ActiveRecord::Base
  belongs_to :rig
  has_many :slave_datas

  enum s_type: [:switch, :analog_reader, :temperature_sensor, :motor, :servo]
end
