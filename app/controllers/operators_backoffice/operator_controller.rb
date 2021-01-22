class OperatorsBackoffice::OperatorController < OperatorsBackofficeController
    def index
        @operators = Operator.all
    end

    def edit
        @operator = Operator.find(params[:id])
        @operator.build_operator_profile if @operator.operator_profile.blank?
    end

    def update
        @operator = Operator.find(params[:id])
        if @operator.update(params_operator)
            redirect_to edit_operators_backoffice_operator_path, notice: "Perfil do Operador atualizado com sucesso!"
        else
            render :edit
        end
    end

    def destroy
        @operator = Operator.find(params[:id])
        if @operator.destroy
            redirect_to operators_backoffice_operator_index_path, notice: "Perfil do Operador apagado com sucesso!"
        else
            render :edit
        end
    end

    def new
        @operator = Operator.new({ "email"=> "default@default.com"})
    end

    def create
        @operator = Operator.new(params_operator_simplified)
        if @operator.save
            #bypass_sign_in(@pilot)
            redirect_to operators_backoffice_operator_index_path, notice: "Perfil do Operador criado com sucesso!"
        else
           render :new
        end
    end

    private
    def params_operator
        params.require(:operator).permit(:email, :password, :password_confirmation,
        operator_profile_attributes: [:id, :first_name, :last_name, :address, :birthdate])
    end

    def params_operator_simplified
        params.require(:operator).permit(:email, :password, :password_confirmation)
    end


end
