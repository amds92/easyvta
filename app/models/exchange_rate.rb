class ExchangeRate < ApplicationRecord
  validates :currency, presence: true, uniqueness: true
  validates :rate, numericality: { greater_than: 0 }

  def self.find_for(currency)
    find_by(currency: currency.upcase)
  end

  def self.rate_for(currency)
    find_for(currency)&.rate
  end

  def stale?
    fetched_at < 25.hours.ago
  end
end
