class Car < ApplicationRecord
  COLORS = ['black', 'blue', 'green'].freeze

  validates :model, presence: true
  validates :color, presence: true, inclusion: { in: COLORS, message: "allowed values are #{COLORS.join(', ')}" }
  validates :price, numericality: { greater_than: 0 }
end
