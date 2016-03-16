class ThingLog < ActiveRecord::Base
  belongs_to :thing
  has_many :laboratories, :through => :things
end
