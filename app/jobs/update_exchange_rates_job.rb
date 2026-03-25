require "net/http"
require "json"

class UpdateExchangeRatesJob < ApplicationJob
  queue_as :default

  # Uses Open Exchange Rates free tier (no API key needed for latest GBP base)
  # Falls back to exchangerate-api.com free endpoint
  BASE_URL = "https://open.er-api.com/v6/latest/GBP"
  CURRENCIES = %w[EUR USD].freeze

  def perform
    response = fetch_rates
    return unless response

    rates = response["rates"]
    return unless rates

    CURRENCIES.each do |currency|
      next unless rates[currency]

      ExchangeRate.find_or_initialize_by(currency: currency).tap do |er|
        er.rate = rates[currency]
        er.fetched_at = Time.current
        er.save!
      end
    end

    Rails.logger.info "[UpdateExchangeRatesJob] Rates updated: #{CURRENCIES.join(', ')}"
  rescue => e
    Rails.logger.error "[UpdateExchangeRatesJob] Failed: #{e.message}"
  end

  private

  def fetch_rates
    uri = URI(BASE_URL)
    response = Net::HTTP.get_response(uri)
    return nil unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  rescue => e
    Rails.logger.error "[UpdateExchangeRatesJob] HTTP error: #{e.message}"
    nil
  end
end
