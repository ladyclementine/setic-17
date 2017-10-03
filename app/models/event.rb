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
  require "#{Rails.root}/config/initializers/packages.rb"

  #validates_associated :schedules  MENOS PARA CAMISA

  def self.total_price
    self.sum(:price)
  end

  def self.total_discount
    total_eventos = self.where.not(price:0).count - 1
    total_discount = total_eventos * 0.05
    if total_discount <= 0.25
      total_discount
    else
      0.25
    end
  end


  #DECONNTO POR PACOTES
  def self.total_discount_by_pack
    preco_total = self.total_price
    count = Hash.new(0)
    price = 0
    self.all.each do |a|
      count[a.event_type.name] += 1 unless a.is_shirt
    end

    belong = false
    pacote_select = nil

    #checar se ta nos conformes do pacote
    Packages::ALL_PACKAGES.each do |k, v|
      #total_users = 2
      #unless total_users >= v[:limit]  #is_ful?
        v[:types].each do |pacote|
          # se quantidade de um tipo do pacote for menor ou igual a minha quantidade por tipo
          if pacote[1] <= count[pacote[0].to_s] ## &&
            belong = true
          else
            belong = false
            break
          end
        end

        if belong == true
          pacote_select = v[:name]
          price = v[:price] + self.plus(k)
        end
      #end
    end
    price = preco_total if price == 0
    [price,pacote_select, count]
  end

  #CARLCULAR PREÇO DOS ITENS FORA DO PACOTE
  def self.plus(pack_name)
    preco_total = self.total_price
    Packages::ALL_PACKAGES[pack_name][:types].each do |p|
      p[1].times do
        event_id = EventType.find_by(name:p[0])
        events = Event.where("price != 0")
        if !events.find_by(event_type_id:event_id).nil?
          preco_total -= events.find_by(event_type_id: event_id).price
        else
          preco_total -= 0
        end
      end
    end
    preco_total
  end


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



  def concurrents(user = nil)
    user.nil? ? events = Event : events = user.events
    #RETORNAR CONFLITANTES

  end


  def remove(user)
    users.delete(user)
    # equivalents.each { |event| event.users.delete(user) }
  end

end
