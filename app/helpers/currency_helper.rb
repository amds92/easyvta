module CurrencyHelper
  CURRENCY_SYMBOLS = {
    "GBP" => "£",
    "EUR" => "€",
    "USD" => "$"
  }.freeze

  # Format a price in pence as GBP
  def format_gbp(pence)
    "£#{sprintf('%.2f', pence / 100.0)}"
  end

  # Format a price in pence converted to another currency
  # Returns nil if rate is not available
  def format_converted(pence, currency)
    rate = ExchangeRate.rate_for(currency)
    return nil unless rate

    amount = (pence / 100.0) * rate
    symbol = CURRENCY_SYMBOLS[currency] || currency
    "#{symbol}#{sprintf('%.2f', amount)}"
  end

  # Returns a string like "£150 / €178" if EUR rate is available
  def price_with_conversion(pence)
    gbp = format_gbp(pence)
    eur = format_converted(pence, "EUR")
    eur ? "#{gbp} <span class=\"price-eur\">/ #{eur}</span>".html_safe : gbp
  end
end
