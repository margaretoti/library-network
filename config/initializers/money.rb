MoneyRails.configure do |config|
  # set default currency
  config.default_currency = :usd

  # display cents
  config.no_cents_if_whole = false
end
