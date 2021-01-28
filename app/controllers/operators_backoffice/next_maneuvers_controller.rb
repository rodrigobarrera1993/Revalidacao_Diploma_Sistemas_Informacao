class OperatorsBackoffice::NextManeuversController < OperatorsBackofficeController
    def index 
        @maneuvers = Maneuver.order('date_maneuver ASC, time_maneuver ASC')
    end

    def edit
        @maneuver = Maneuver.find(params[:id])
        
        @hour_options = []
        (0..23).each  do |hour|
            @hour_options.push([hour,hour])
        end

        @min_options = []
        (0..59).each  do |min|
            @min_options.push([min,min])
        end

        @pilot_profile_options = []
        all_pilot_profile = PilotProfile.all
        all_pilot_profile.each do |pilot_profile|
            @pilot_profile_options.push(["#{pilot_profile.first_name} #{pilot_profile.last_name}", pilot_profile.id])
        end

        #Maneuver type
        @maneuver_type_options = [["Entrada",1],["Saída",2]]
        if @maneuver.type_maneuver == "Entrada"
            @maneuver_type_id = 1
        else
            @maneuver_type_id = 2
        end

        @vessel_options = []
        all_vessels = Vessel.all
        all_vessels.each do |vessel|
            @vessel_options.push([vessel.name, vessel.id])
        end

        @terminal_options = []
        all_terminals = Terminal.all
        all_terminals.each do |terminal|
            @terminal_options.push([terminal.name, terminal.id])
        end

    end

    def update
        @maneuver = Maneuver.find(params[:id])
        @maneuver.date_maneuver = params[:maneuver][:date_maneuver]
        @maneuver.time_maneuver =  Time.new(2018,1,1,params[:maneuver][:hour],params[:maneuver][:minute],0)
        @maneuver.pilot_profile = PilotProfile.find(params[:maneuver][:pilot_profile][:pilot_profile_id])
        if params[:maneuver][:maneuver_type] == "1"
            @maneuver.type_maneuver = "Entrada"
        else
            @maneuver.type_maneuver = "Saída"
        end

        @maneuver.vessel = Vessel.find(params[:maneuver][:vessel][:vessel_id])
        @maneuver.vessel_displacement = params[:maneuver][:vessel_displacement].to_f
        @maneuver.terminal = Terminal.find(params[:maneuver][:terminal][:terminal_id])

        if  @maneuver.save
            #bypass_sign_in(@pilot)
            redirect_to edit_operators_backoffice_next_maneuver_path, notice: "Manobra atualizada com sucesso!"
        else
            render :edit
        end

    end

    def destroy
        @maneuver = Maneuver.find(params[:id])
        if  @maneuver.destroy
            redirect_to operators_backoffice_next_maneuvers_path, notice: "Manobra apagada com sucesso!"
        else
            render :edit
        end
    end

    def new
        @maneuver = Maneuver.new

        @hour_options = []
        (0..23).each  do |hour|
            @hour_options.push([hour,hour])
        end

        @min_options = []
        (0..59).each  do |min|
            @min_options.push([min,min])
        end

        @pilot_profile_options = []
        all_pilot_profile = PilotProfile.all
        all_pilot_profile.each do |pilot_profile|
            @pilot_profile_options.push(["#{pilot_profile.first_name} #{pilot_profile.last_name}", pilot_profile.id])
        end

        #Maneuver type
        @maneuver_type_options = [["Entrada",1],["Saída",2]]
        if @maneuver.type_maneuver == "Entrada"
            @maneuver_type_id = 1
        else
            @maneuver_type_id = 2
        end

        @vessel_options = []
        all_vessels = Vessel.all
        all_vessels.each do |vessel|
            @vessel_options.push([vessel.name, vessel.id])
        end

        @terminal_options = []
        all_terminals = Terminal.all
        all_terminals.each do |terminal|
            @terminal_options.push([terminal.name, terminal.id])
        end

    end

    def create
        @maneuver = Maneuver.new

        @maneuver.date_maneuver = params[:maneuver][:date_maneuver]
        @maneuver.time_maneuver =  Time.new(2018,1,1,params[:maneuver][:hour],params[:maneuver][:minute],0)
        @maneuver.pilot_profile = PilotProfile.find(params[:maneuver][:pilot_profile][:pilot_profile_id])
        if params[:maneuver][:maneuver_type] == "1"
            @maneuver.type_maneuver = "Entrada"
        else
            @maneuver.type_maneuver = "Saída"
        end

        @maneuver.vessel = Vessel.find(params[:maneuver][:vessel][:vessel_id])
        @maneuver.vessel_displacement = params[:maneuver][:vessel_displacement].to_f
        @maneuver.terminal = Terminal.find(params[:maneuver][:terminal][:terminal_id])
        @maneuver.relatory = Relatory.create!
        @maneuver.operator_profile = OperatorProfile.find(current_operator.operator_profile.id)

        if @maneuver.save!
            #bypass_sign_in(@pilot)
            redirect_to operators_backoffice_next_maneuvers_path, notice: "Manobra criada com sucesso!"
        else
           render :new
        end

    end
end
