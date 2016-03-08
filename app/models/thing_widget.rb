class ThingWidget < ActiveRecord::Base
  has_and_belongs_to_many :laboratories
 end
