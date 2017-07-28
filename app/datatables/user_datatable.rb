class UserDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :edit_crew_user_path, :payment_view, :lot_name, :ej_name, :button_edit, :button_login,
    :payment_view_pdf

  def view_columns
    @view_columns ||= {
      name: { source: "User.name" },
      email: { source: "User.email" },
      payment: { source: "Payment.portions,method", searchable: false},
      lot: { source: "User.lot_id"},
      fed: { source: "User.federation_check"},
      ej: {source: "User.junior_enterprise"},
      edit: {source: "User.id", searchable: false, orderable: false},
      login: {source: "User.id",  searchable: false, orderable: false},
    }
  end

  def data
    records.map do |record|
      {
        name: record.name,
        email: record.email,
        payment: payment_view(record.payment),
        payment_pdf: payment_view_pdf(record.payment),
        lot: lot_name(record.lot),
        ej: ej_name(record.junior_enterprise),
        fed: record.federation_check,
        edit: button_edit(record.id),
        login: button_login(record.id)
      }
    end
  end

  def table_select
    case options[:table_select]
    when 'all'
      User.includes(:payment).all
    when 'qualified'
      User.includes(:payment).where.not(lot_id:nil)
    when 'pay'
      User.joins(:payment).where("payments.portion_paid!=0")
    end
  end

  private


  def get_raw_records
    table_select
  end

end
