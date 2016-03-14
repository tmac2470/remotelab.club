class Laboratory < ActiveRecord::Base
  belongs_to :user
  has_many :things
  has_many :thing_logs, :through => :things
  has_many :thing_widgets

  enum lab_type: [:publish_only, :interactive]
end
