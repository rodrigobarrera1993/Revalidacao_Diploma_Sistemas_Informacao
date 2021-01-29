class Site::ManeuversPerformedController < SiteController
    def index
        @maneuvers = Maneuver.where( { is_finished: true }).order('date_maneuver ASC, time_maneuver ASC')
    end
    

end
