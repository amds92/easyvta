# Enqueue an exchange rate update on boot if no rates exist or they are stale
Rails.application.config.after_initialize do
  next unless Rails.env.development? || Rails.env.production?

  begin
    rate = ExchangeRate.find_by(currency: "EUR")
    UpdateExchangeRatesJob.perform_later if rate.nil? || rate.stale?
  rescue => e
    Rails.logger.warn "[ExchangeRates] Could not enqueue update on boot: #{e.message}"
  end
end
