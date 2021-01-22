class Maneuver < ApplicationRecord
  belongs_to :vessel
  belongs_to :terminal
  belongs_to :operator_profile
  belongs_to :pilot_profile
  belongs_to :relatory
end
