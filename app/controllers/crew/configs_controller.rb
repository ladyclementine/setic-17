class Crew::ConfigsController < Crew::BaseController
   before_action :set_config, only: [:update]

    def edit
    end

    # PATCH/PUT /events/1
    def update
      if @config.update(config_params)
      redirect_to edit_crew_config_path, notice: 'Salvo com sucesso!'
      else
        render :edit
      end
    end

    def set_config
      @config = Config.first
    end

    def config_params
      params.require(:config).permit(:name, :sigla, :logo, :conta, :agencia, :beneficiado, :banco, :local, :email, :faq, :close)
    end

end
