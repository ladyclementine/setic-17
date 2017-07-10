module Crew::UsersHelper
  def count_paymeny_ej(usuarios)
    usuarios.select{ |user| !user.payment.nil? && user.payment.portion_paid > 0}.count
  end
end