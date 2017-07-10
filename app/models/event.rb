class Event < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # New code compactado
  # Old: https://github.com/GTi-Jr/ECEJ-2016/blob/master/app/models/event.rb
  # 2/05/17
  # Patrick C. M
  has_many :subscriptions
  has_many :users, through: :subscriptions
  validates :name,
    presence: true
  validates :facilitator,
    presence: true
  validates :limit,
    presence: true
  validates :limit,
    numericality: { greater_than: -1, message: " deve ser maior= zero." }
  validates :start,
    presence: true
  validates :end,
    presence: true
  validate :start_must_be_smaller_than_end

  #@@hours = 0..23
  #@@minutes = 0..59

  #def self.times
  #  times = []
  #  @@hours.each do |hour|
  #    @@minutes.each do |minute|
  #     join = "#{hour}:#{minute}".to_time.strftime('%H:%M')
  #     times << join
  #   end
  # end
  # times
  #end

  def self.days
    self.all.group_by{|d| d.start.to_date}
  end

  def self.hours_start
    self.all.group_by{|d| d.start.strftime('%H:%M') }.sort_by {|hour,e| hour }
  end

  def self.my_days(user)
    self.users
  end

  def self.join_events_by_time
    events_by_time = []

    self.days.sort_by {|day| day[0]}.each do |day|
      join = { date: day[0], hours: [] }

      events = days.select {|k,v| k == day[0]}.values
      self.hours_start.each do |hour,event|
        time_events = events[0].select {|event| event[:start].strftime('%H:%M')  == hour }
        join[:hours] << { time: hour, events: time_events.sort_by {|name| name} } unless time_events.empty?
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

  def concurrents(user = nil)
    user.nil? ? events = Event : events = user.events

    events.select do |event|
      event != self &&
        ((event.start >= self.start && event.start < self.end) ||
         (event.end > self.start && event.end <= self.end) ||
         (event.start <= self.start && event.end >= self.end))
        end
  end


  def remove(user)
    users.delete(user)
    # equivalents.each { |event| event.users.delete(user) }
  end

  def total_ejs
    self.users.all.where.not(junior_enterprise:nil).order(:junior_enterprise).group_by{|d| d.junior_enterprise.split(' ').first.downcase}
  end

  def ejs_names
    self.total_ejs.map { |k,usuarios| usuarios.map{ |h| h.junior_enterprise_new}.max.titleize }.join(' | ')
  end

  def membros_ejs(user)
    ej = user.junior_enterprise.split(' ')[0].downcase
    results = self.users.where.not(junior_enterprise:nil).where.not(id:user.id).where("lower(split_part(junior_enterprise, ' ', 1)) = ?", ej)
  end

  # Validator method
  def start_must_be_smaller_than_end
    if !self.start.nil? && !self.end.nil?
      errors.add(:start, "deve ser menor que a data de término") if self.start > self.end
    end
  end
end
