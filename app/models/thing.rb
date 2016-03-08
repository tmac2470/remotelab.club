class Thing < ActiveRecord::Base
  has_and_belongs_to_many :laboratories
  belongs_to :gateway
  has_many :thing_datas

  enum s_type: [:switch, :analog_reader, :temperature_sensor, :motor, :servo, :sensorTag]
 end
