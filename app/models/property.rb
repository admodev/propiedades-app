class Property < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :price, numericality: { major_than: 0 }
  validates :commune, :address, presence: true
  validates :description, format: { without: /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b|\bhttps?:\/\/\S+\b|\b\d{3}[-.\s]?\d{3}[-.\s]?\d{4}\b/, message: "description field should not contain contact data." }
end
