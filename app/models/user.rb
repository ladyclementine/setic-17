class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook]
  attr_writer :login_face

  acts_as_paranoid

  #INSTALAR: apt-get install imagemagick
  mount_uploader :avatar, AvatarUploader

  has_many :subscriptions
  has_many :events, through: :subscriptions
  #has_many :shirts, -> { where(is_shirt: true) }, through: :subscriptions, class_name: "Event"
  has_one :payment

  enum certificate: { 'SIM':true, 'NÃO':false }
  #VALIDAÇÃO PARA CONCLUSÃO DE CADASTRO
  validates_presence_of :name, :general_register, :birthday ,:cpf, :course, :semester, :university, on: [:update], :allow_nil => true

  usar_como_cpf :cpf

  scope :pays, -> { includes(:payment).where(payments: {status: true})}
  scope :no_pays, -> { includes(:payment).where(payments: {status: false })}
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
  # def has_concurrent_event?(event)

  #   hora = event.schedules.first
  #   #check_schedules = self.events.where(is_shirt: false).where("schedules.start_time < ? AND schedules.end_time > ?", hora.start_time, hora.end_time)
  #   check_schedules = self.events.where(is_shirt: false).collect { |e| e.schedules.where("schedules.start_time < ? AND schedules.end_time > ?", hora.start_time, hora.end_time) }

  #   p check_schedules
  #   false
  # end

   def has_concurrent_event?(event)
    check_schedules = []
    conflit_schedules = []
    check_schedules = self.events.where.not(id: event.id).collect { |e| e.schedules }

    event.schedules.each do |schedule|
      conflit_schedules << schedule.start_time_between
    end
   result = (conflit_schedules.flatten & check_schedules.flatten)
   false
   true if !result.empty?
  end



  # def self.on_day(date)
  #   joins(:sessions).where("session.start < ? AND session.end > ?", date.end_of_day, date.beginning_of_day)
  # end


end
