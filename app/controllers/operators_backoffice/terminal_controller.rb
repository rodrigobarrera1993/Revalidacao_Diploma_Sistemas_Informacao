class OperatorsBackoffice::TerminalController < OperatorsBackofficeController
    def index
        @terminals = Terminal.all
    end

    def edit
        @terminal = Terminal.find(params[:id])
    end

    def update
        @terminal = Terminal.find(params[:id])

        if @terminal.update(params_terminal)
            redirect_to edit_operators_backoffice_terminal_path, notice: "Terminal atualizado com sucesso!"
        else
            render :edit
        end

    end

    def destroy
        @terminal = Terminal.find(params[:id])
        if @terminal.destroy
            redirect_to operators_backoffice_terminal_index_path, notice: "Terminal apagado com sucesso!"
        else
            render :edit
        end
    end

    def new
        @terminal = Terminal.new
    end

    def create
        @terminal = Terminal.new(params_terminal)
        if @terminal.save
            #bypass_sign_in(@pilot)
            redirect_to operators_backoffice_terminal_index_path, notice: "Terminal criado com sucesso!"
        else
           render :new
        end
        
    end

    private

    def params_terminal
        params.require(:terminal).permit(:name, :cargo, :url_image)
    end

end
