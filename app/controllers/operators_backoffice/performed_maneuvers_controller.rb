class OperatorsBackoffice::PerformedManeuversController < OperatorsBackofficeController
    def index
        @maneuvers = Maneuver.where( { is_finished: true }).order('date_maneuver ASC, time_maneuver ASC')
    end

    
    def edit
        @maneuver = Maneuver.find(params[:id])
    end
    
end
