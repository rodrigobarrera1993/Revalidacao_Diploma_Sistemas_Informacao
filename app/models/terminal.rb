class Terminal < ApplicationRecord
    has_many :maneuvers, :dependent => :destroy
end
