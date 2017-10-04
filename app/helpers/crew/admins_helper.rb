module Crew::AdminsHelper
  def select_pay_by_type_count(type)
    Payment.where(method: type).count unless type.nil?
  end

  def select_payed_by_type_count(type)
    Payment.where(method: type, status: "Confirmado").count unless type.nil?
  end
end
