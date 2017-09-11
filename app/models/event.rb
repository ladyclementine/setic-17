class Event < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # 2/05/17
  # Patrick C. M
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :schedules, dependent: :destroy
  belongs_to :event_type

  validates :name, presence: true
  #validates :facilitator, presence: true, unless: Proc.new{|a| a.is_shirt == true }
  validates :limit, presence: true
  validates :limit, numericality: { greater_than: -1, message: " deve ser maior= zero." }


  #validates_associated :schedules  MENOS PARA CAMISA

  def self.days
    Schedule.all.group_by{|d| d.start_time.to_date }
  end

  def self.hours_start
    Schedule.all.group_by{|d| d.start_time.strftime('%H:%M') }.sort_by {|hour,e| hour }
  end

  def self.my_days(user)
    self.users
  end

  # dificil, foi! Mas deu certo
  def self.join_events_by_time
    events_by_time = []
    self.days.sort_by {|day| day[0]}.each do |day|
      join = { date: day[0], hours: [] }
      events = days.select {|k,v| k == day[0]}.values
      self.hours_start.each do |hour,schedule|
        time_events = events[0].select {|s| s[:start_time].strftime('%H:%M')  == hour }
        join[:hours] << { time: hour, events: time_events } unless time_events.empty?
      end
      events_by_time << join
    end
    events_by_time
  end


  def full?
    users.count >= limit
  end

  def add(user)
    users << user
    # equivalents.each { |event| event.users << user }
  end

  def contains?(user)
    return true if user.in?(users)
    # equivalents.each { |event| return true if user.in?(event.users) }
    false
  end

  # def concurrents(user = nil)
  #   user.nil? ? events = Event : events = user.events

  #   events.select do |event|
  #     event != self &&
  #       ((event.start >= self.start && event.start < self.end) ||
  #        (event.end > self.start && event.end <= self.end) ||
  #        (event.start <= self.start && event.end >= self.end))
  #       end
  # end


  def concurrents(user = nil)
    user.nil? ? events = Event : events = user.events


    # events.each do |event|
    #   event.schedules.select do |schedule|
    #       schedule != self &&
    #         ((schedule.start_time >= self.start_time && schedule.start_time < self.end_time) ||
    #          (schedule.end_time > self.start_time && schedule.end_time <= self.end_time) ||
    #          (schedule.start_time <= self.start_time && schedule.end_time >= self.end_time))
    #         end

    #end

  end


  def remove(user)
    users.delete(user)
    # equivalents.each { |event| event.users.delete(user) }
  end

end
