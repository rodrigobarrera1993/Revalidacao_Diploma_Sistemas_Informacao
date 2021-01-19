class PilotsBackoffice::ProfileController < PilotsBackofficeController
    before_action :set_user
    
    def edit
        @pilot.build_pilot_profile if @pilot.pilot_profile.blank?
    end

    def update
        if @pilot.update(params_pilot)
            bypass_sign_in(@pilot)
            redirect_to pilots_backoffice_profile_path, notice: "Perfil do Prático atualizado com sucesso!"
        else
           render :edit
        end
    end

    private

    def set_user
        @pilot = Pilot.find(current_pilot.id)
    end

    def params_pilot
        params.require(:pilot).permit(:email, :password, :password_confirmation,
        pilot_profile_attributes: [:id, :first_name, :last_name, :address, :birthdate])
    end
end
