class OperatorsBackoffice::VesselController < OperatorsBackofficeController
    def index
        @vessels = Vessel.all
    end

    def edit
        @vessel = Vessel.find(params[:id])
    end

    def update
        @vessel = Vessel.find(params[:id])
        if @vessel.update(params_vessel)
            redirect_to edit_operators_backoffice_vessel_path, notice: "Navio atualizado com sucesso!"
        else
            render :edit
        end
    end

    def destroy
        @vessel = Vessel.find(params[:id])
        if @vessel.destroy
            redirect_to operators_backoffice_vessel_index_path, notice: "Navio apagado com sucesso!"
        else
            render :edit
        end
    end

    def new
        @vessel = Vessel.new
    end

    def create
        @vessel = Vessel.new(params_vessel)
        if @vessel.save
            #bypass_sign_in(@pilot)
            redirect_to operators_backoffice_vessel_index_path, notice: "Navio criado com sucesso!"
        else
           render :new
        end
    end
    private

    def params_vessel
        params.require(:vessel).permit(:name, :mmsi, :length, :width, :type_vessel, :url_image)
    end

end
