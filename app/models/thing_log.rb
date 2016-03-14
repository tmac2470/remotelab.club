class ThingLog < ActiveRecord::Base
  belongs_to :thing, inverse_of: :thing_logs
end
