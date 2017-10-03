class Schedule < ApplicationRecord
  belongs_to :event

  validates_presence_of :start_time, :end_time
  validates_datetime :end_time, after: :start_time


  def start_time_between
    begin
      schedules = Schedule.where.not(id: self.id).where('? BETWEEN start_time and end_time', self.start_time)
      raise unless schedules.any?
      [schedules]
    rescue => e
      []
    end
  end

  def end_time_between
    begin
      schedules = Schedule.where.not(id: self.id).where('? BETWEEN start_time and end_time', self.end_time)
      raise unless schedules.any?
      [schedules]
    rescue => e
      []
    end
  end

  #horário de término não pode ser em uma data anterior a data de início
  def end_time_bigger?
    self.end_time >= self.start_time
  end

  end
