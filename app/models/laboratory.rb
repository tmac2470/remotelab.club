class Laboratory < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :things
  has_many :thing_logs, :through => :things
  has_many :thing_widgets
  validates :title, presence: true
  enum lab_type: [:publish_only, :interactive]
end
