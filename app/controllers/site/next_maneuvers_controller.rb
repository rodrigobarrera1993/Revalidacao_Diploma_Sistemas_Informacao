class Site::NextManeuversController < SiteController
    def index
        @maneuvers = Maneuver.where( { is_finished: false }).order('date_maneuver ASC, time_maneuver ASC')
    end

   

end
