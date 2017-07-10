class Room < ApplicationRecord
  belongs_to :hotel
  has_many :users
  validates_presence_of :hotel, message: "Hotel não pode ficar em branco." 
  validates :number,
    uniqueness: { scope: :hotel, message: "Quarto já cadastrado nesse hotel." },
    numericality: { greater_than: 0, message: "A número deve ser maior que zero." }

  validates :capacity,
    numericality: { greater_than: 0, message: "A capacidade deve ser maior que zero." }
  validates :capacity,
    numericality: { less_than: 7, message: "A capacidade deve ser menor que 7." }


  def full?
    self.users.count >= capacity.to_i
  end

  # OVERRIDE
  def to_s
    "#{number} | #{hotel.name}"
  end
end
