class Vessel < ApplicationRecord
    has_many :maneuvers, :dependent => :destroy
end
