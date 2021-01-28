class PilotsBackoffice::MyNextManeuversController < PilotsBackofficeController
    def index
        pilot = Pilot.find(current_pilot.id)
        pilot_profile_id = pilot.pilot_profile.id
        maneuvers_from_this_pilot = Maneuver.where(pilot_profile_id: pilot_profile_id)
        @maneuvers = maneuvers_from_this_pilot.where(is_finished: false).order('date_maneuver ASC, time_maneuver ASC')
    end
end
