class PilotsBackoffice::DashboardController < PilotsBackofficeController
    def index
        @pilot = Pilot.find(current_pilot.id)
    end
end
