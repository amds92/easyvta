class Product < ApplicationRecord
  has_one_attached :image
  has_many :order_items
  has_many :orders, through: :order_items

  enum :stock_status, { in_stock: 0, out_of_stock: 1, coming_soon: 2 }

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :price_pence, presence: true, numericality: { greater_than: 0 }
  validates :stock_status, presence: true

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

  scope :ordered, -> { order(:position, :name) }
  scope :visible, -> { where(featured: [true, false]) }

  def price
    "£#{sprintf('%.2f', price_pence / 100.0)}"
  end

  def in_stock?
    stock_status == "in_stock"
  end

  private

  def generate_slug
    self.slug = name.parameterize
  end
end
