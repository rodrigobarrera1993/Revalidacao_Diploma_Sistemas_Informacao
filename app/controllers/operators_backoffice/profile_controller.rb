class OperatorsBackoffice::ProfileController < OperatorsBackofficeController
    before_action :set_user
    
    def edit
        @operator.build_operator_profile if @operator.operator_profile.blank?
    end

    def update
        if @operator.update(params_operator)
            bypass_sign_in(@operator)
            redirect_to operators_backoffice_profile_path, notice: "Perfil do Operador atualizado com sucesso!"
        else
           render :edit
        end
    end

    private

    def set_user
        @operator = Operator.find(current_operator.id)
    end

    def params_operator
        params.require(:operator).permit(:email, :password, :password_confirmation,
        operator_profile_attributes: [:id, :first_name, :last_name, :address, :birthdate])
    end

end
