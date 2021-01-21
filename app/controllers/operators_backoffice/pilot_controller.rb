class OperatorsBackoffice::PilotController < OperatorsBackofficeController
    def index
        @pilots = Pilot.all
    end

    def edit
        @pilot = Pilot.find(params[:id])
        @pilot.build_pilot_profile if @pilot.pilot_profile.blank?
    end

    def update
        @pilot = Pilot.find(params[:id])
        if @pilot.update(params_pilot)
            #bypass_sign_in(@pilot)
            redirect_to edit_operators_backoffice_pilot_path, notice: "Perfil do Prático atualizado com sucesso!"
        else
           render :edit
        end
    end

    def new
       @pilot = Pilot.new({ "email"=> "default@default.com"})
    end

    def destroy
        @pilot = Pilot.find(params[:id])
        if @pilot.destroy
          redirect_to operators_backoffice_pilot_index_path, notice: "Prático apagado com sucesso"
        else
           render :index
        end
      end

    def create
        @pilot = Pilot.new(params_pilot_simplified)
        if @pilot.save
            #bypass_sign_in(@pilot)
            redirect_to operators_backoffice_pilot_index_path, notice: "Perfil do Prático criado com sucesso!"
        else
           render :new
        end
    end
    

    private
    def params_pilot
        params.require(:pilot).permit(:email, :password, :password_confirmation,
        pilot_profile_attributes: [:id, :first_name, :last_name, :address, :birthdate])
    end

    def params_pilot_simplified
        params.require(:pilot).permit(:email, :password, :password_confirmation)
    end

end
