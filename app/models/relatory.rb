class Relatory < ApplicationRecord
    has_one :maneuver, :dependent => :delete
end
