class Property < ApplicationRecord
  self.inheritance_column = :_type_disabled
  belongs_to :user
  has_one_attached :photo

  validates :price, numericality: { major_than: 0 }
  validates :commune, :address, presence: true
  validates :description, format: { without: /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b|\bhttps?:\/\/\S+\b|\b\d{3}[-.\s]?\d{3}[-.\s]?\d{4}\b/, message: "la descripcion no puede contener informacion de contacto." }

  # Atributos para el precio cambiario
  attribute :price_usd, :decimal, default: 0
  attribute :currency, :string, default: 'CLP'
  
  validates :price, numericality: { greater_than: 0 }
end
