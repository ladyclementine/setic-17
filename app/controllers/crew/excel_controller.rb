class Crew::ExcelController < Crew::BaseController
  def lot_users
    @lot = Lot.find(params[:id])
    @users = @lot.users.order(:name)

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "Lista de congressistas no lote #{@lot.name}.csv" }
      format.xls
    end
  end


  def excel_handler
    @ej = User.all
    excel = ExcelHandler.new model: User
    @possible_columns = excel.possible_columns
  end

  def users
    @users || User
  end

  def reset_query_state
    @users = nil
  end

  def filter(payment, ej)
    reset_query_state

    #FILTRO DE EJ
    if ej!=""
      @users = users.where("lower(split_part(junior_enterprise, ' ', 1)) = ?", "#{ej}")
    end

    #FILTRO DE PAGAMENTO
    case payment
    when '0'
      @users = users.all
    when '1'
      @users = users.pays
    when '2'
      @users = users.pays_total
    when '3'
      @users = users.qnt_pays_partial
    when '4'
      @users = users.no_pays
    when '5'
      @users = users.no_selected_payment_e
    end


    @users

  end

  def generate_xls
    excel = ExcelHandler.new model: User
    @columns = excel.get_selected_columns_from_params(params, :selected_columns)
    @users = filter(params[:pay_status], params[:filtro][:ej_name])
    filename = "relatorio_#{Time.now}"

    respond_to do |format|
      format.html
      format.xls do
        if (params[:email_relatorio] != "" && params[:email_relatorio]=~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
          view_xls = render_to_string :xls => 'MyXLS'
          RelatorioMailer.send_email(view_xls, params[:email_relatorio], params[:email_relatorio_conteudo][:info]).deliver_now
        end
        response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xls"'
      end
      format.csv
    end
  end

  def ejlist
    @ej = User.all.where.not(junior_enterprise:nil).order(:junior_enterprise).group_by{|d| d.junior_enterprise.split(' ').first.downcase}
    respond_to do |format|
      format.html
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="lista_ej_pay.xls"'
      end
      format.csv
    end

  end

  def fedlist
    @fed = User.all.where.not(federation:"").order(:federation).group_by{|d| d.federation.split(' ').first.downcase}
    respond_to do |format|
      format.html
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="lista_federacoes.xls"'
      end
      format.csv
    end

  end

end
