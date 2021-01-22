class PilotProfile < ApplicationRecord
  belongs_to :pilot
  has_many :maneuvers
end
