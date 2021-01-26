class OperatorsBackoffice::NextManeuversController < OperatorsBackofficeController
    def index 
        @maneuvers = Maneuver.order('date_maneuver ASC, time_maneuver ASC')
    end

    def edit
        @maneuver = Maneuver.find(params[:id])
    end
end
