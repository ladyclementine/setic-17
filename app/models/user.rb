class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable
  #devise :omniauthable, :omniauth_providers => [:facebook]
  #attr_writer :login_face

  acts_as_paranoid

  #INSTALAR: apt-get install imagemagick
  mount_uploader :avatar, AvatarUploader

  has_many :subscriptions
  has_many :events, through: :subscriptions

  #has_many :shirts, -> { where(is_shirt: true) }, through: :subscriptions, class_name: "Event"
  has_one :payment

  enum certificate: { 'SIM':true, 'NÃO':false }
  #VALIDAÇÃO PARA CONCLUSÃO DE CADASTRO
  validates_presence_of :name, :birthday , :semester, :university, on: [:update], :allow_nil => true


  scope :pays, -> { includes(:payment).where(payments: {status: true})}
  scope :no_pays, -> { includes(:payment).where(payments: {status: false })}
  scope :no_pays_or_no_select, -> { includes(:payment).where(payments: {status: false }).or(includes(:payment).where(payments: {id: nil})) }


  scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }
  scope :no_finalized, -> { where(completed: nil) }
  scope :no_selected_payment, -> { includes(:payment).where(payments: {id: nil})}


  def total_cart
    self.events.sum(:price) + self.shirts.sum(:price)
  end


  def total_cart_discount
    self.events.total_discount_by_pack[0] * (1 - self.events.total_discount)
  end


  # PARA O RELATORIO - EXCEL
  # Verificar se o cadastro possui associação com o facebook
  def login_face
    self.uid ? 'Sim' : 'Não'
  end

  # Returns the user's first name
  def first_name
    name.split(' ').first
  end

  # Returns the user's last name
  def last_name
    name.split(' ').last
  end

  def two_names
    name.split(' ').length == 1 ? first_name : "#{first_name} #{last_name}"
  end

  #preencheu todos os dados pessoais?
  def is_completed?
    return false unless self.completed
    true
  end


  #LOGIN VIA FACEBOOK
  #CADASTRAR SE N TIVER CADASTRADO, VERIFICANDO O LOTE
  #LOGAR
  def self.from_omniauth(auth)
    #VERIFICA SE EXISTE UMA CONTA ASSOCIADA OU EMAIL
    if !where(uid: auth.uid).any?
      if !where(email: auth.info.email).any?
        #CRIAR CONTA SE NÃO EXISITIR E SE LOTE TIVER ABERTO
        create do |user|
          if auth.info.email.nil?
            #GERAR RANDOM EMAIL
            r_email = "gti_#{((1..1000).to_a).sample}_#{((2..3000).to_a).sample}@#{['hotmail.com','gmail.com','gti.com','yahoo.com','gti.com.br','eventi.com','random.com'].sample}"
            user.email = r_email
            user.email_face = r_email
          else
            user.email = auth.info.email
            user.email_face = auth.info.email
          end
          user.password = Devise.friendly_token[0,20]
          user.name = auth.info.name   # assuming the user model has a name
          #user.remote_avatar_url = auth.info.image.gsub('http://','https://') unless auth.info.image.nil?
          user.uid = auth.uid
          #user.gender = auth.info.gender
          user.skip_confirmation!
          user.save!
          return {status: 'create_user', data: user}
        end
      else
        return {status: 'email_associate'}
      end
    else
      return {status: 'success', data: where(uid: auth.uid).first}
    end
  end

  #evento
  #  scope :no_pays, -> { includes(:payment).where(payments: {status: false })}
  def has_concurrent_event?(event)
    condition = false
    check_schedules = self.events.where.not(id: event.id).where(is_shirt: false).collect { |e| e.schedules }.flatten
    check_schedules.each do |user_event|
      event.schedules.each do |schedule1|
        condition = user_event.end_time < schedule1.start_time ||
          (user_event.end_time.strftime('%Y/%m/%d %H:%M:%S') == schedule1.start_time.strftime('%Y/%m/%d %H:%M:%S')) ||
          (user_event.start_time > schedule1.end_time) ||
          (user_event.start_time.strftime('%Y/%m/%d %H:%M:%S') == schedule1.end_time.strftime('%Y/%m/%d %H:%M:%S'))
        return true unless condition
      end
    end
    false
  end

  def has_concurrent_event1?(event)
    events.each do |user_event|
      condition =   (user_event.end < event.start) ||
        (user_event.end.strftime('%Y/%m/%d %H:%M:%S') == event.start.strftime('%Y/%m/%d %H:%M:%S')) ||
        (user_event.start > event.end) ||
        (user_event.start.strftime('%Y/%m/%d %H:%M:%S') == event.end.strftime('%Y/%m/%d %H:%M:%S'))
      return true unless condition
    end
    false
  end

  #  def has_concurrent_event?(event)
  #   check_schedules = []
  #   conflit_schedules = []
  #   check_schedules = self.events.where.not(id: event.id).collect { |e| e.schedules }

  #   event.schedules.each do |schedule|
  #     conflit_schedules << schedule.start_time_between
  #   end
  #  result = (conflit_schedules.flatten & check_schedules.flatten)
  #  false
  #  true if !result.empty?
  # end



  # def self.on_day(date)
  #   joins(:sessions).where("session.start < ? AND session.end > ?", date.end_of_day, date.beginning_of_day)
  # end


end
