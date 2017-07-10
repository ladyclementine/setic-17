class Lot < ApplicationRecord
  has_many :users

  
  def self.active_lot
    now = Time.now
    Lot.all.each do |lot|
      if now > lot.start_date && now < lot.end_date
        return lot
      end
    end
    nil
  end

  def is_full?
    self.users.count >= self.limit
  end

  def qnt_pays_total
    self.users.joins(:payment).where("payments.portion_paid=payments.portions").count
  end

  def qnt_pays_partial
    self.users.joins(:payment).where("payments.portion_paid>0").where("payments.portion_paid!=payments.portions").count
  end

  def self.totalLimit
    self.sum(:limit)
  end

  def to_s
    "#{name}"
  end

end
