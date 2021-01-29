class PilotsBackoffice::MyNextManeuversController < PilotsBackofficeController
    def index
        pilot = Pilot.find(current_pilot.id)
        pilot_profile_id = pilot.pilot_profile.id
        maneuvers_from_this_pilot = Maneuver.where(pilot_profile_id: pilot_profile_id)
        @maneuvers = maneuvers_from_this_pilot.where(is_finished: false).order('date_maneuver ASC, time_maneuver ASC')
    end

    def edit
        @maneuver = Maneuver.find(params[:id])

        @grades_options = []
        (1..5).each  do |grade|
            @grades_options.push([grade, grade])
        end
        
    end

    def update
        @maneuver = Maneuver.find(params[:id])

        @maneuver.relatory.maneuver_description = params[:maneuver][:relatory][:maneuver_description]
        @maneuver.relatory.vessel_tendecies = params[:maneuver][:relatory][:vessel_tendecies]
        @maneuver.relatory.maneuver_safety = params[:maneuver][:relatory][:maneuver_safety].to_i
        @maneuver.relatory.ladder_safety = params[:maneuver][:relatory][:ladder_safety].to_i
        @maneuver.is_finished = true
        if  @maneuver.save! && @maneuver.relatory.save!
            #bypass_sign_in(@pilot)
            redirect_to pilots_backoffice_my_next_maneuvers_path, notice: "Relatório Enviado com Sucesso!"
        else
            render :edit
        end
    end
    
end
