class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price_pence, numericality: { greater_than: 0 }
  validates :product_name, presence: true

  def subtotal_pence
    quantity * unit_price_pence
  end

  def subtotal
    "£#{sprintf('%.2f', subtotal_pence / 100.0)}"
  end

  def unit_price
    "£#{sprintf('%.2f', unit_price_pence / 100.0)}"
  end
end
