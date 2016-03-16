class Rig < ActiveRecord::Base
  belongs_to :user
  has_many :slave_modules
  has_many :slave_widgets

  enum rig_type: [:publish_only, :interactive]
end
