class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum :status, {
    pending: 0,
    confirmed: 1,
    shipped: 2,
    delivered: 3,
    cancelled: 4
  }

  validates :reference, presence: true, uniqueness: true
  validates :customer_name, :customer_email, :address_line1, :city, :postal_code, :country, presence: true
  validates :customer_email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :total_pence, numericality: { greater_than_or_equal_to: 0 }

  before_validation :generate_reference, on: :create

  def total
    "£#{sprintf('%.2f', total_pence / 100.0)}"
  end

  def status_label
    {
      "pending" => "Pending",
      "confirmed" => "Confirmed",
      "shipped" => "Shipped",
      "delivered" => "Delivered",
      "cancelled" => "Cancelled"
    }[status] || status.humanize
  end

  def status_color
    {
      "pending" => "amber",
      "confirmed" => "blue",
      "shipped" => "purple",
      "delivered" => "green",
      "cancelled" => "red"
    }[status] || "grey"
  end

  private

  def generate_reference
    self.reference ||= "VTA-#{Time.now.strftime('%Y%m%d')}-#{SecureRandom.hex(3).upcase}"
  end
end
