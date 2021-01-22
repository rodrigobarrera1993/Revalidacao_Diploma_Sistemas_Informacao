class OperatorProfile < ApplicationRecord
  belongs_to :operator
  has_many :maneuvers
end
