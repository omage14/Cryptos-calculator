class Transaction < ApplicationRecord
  ALLOWED_CRYPTOS = %i[BTC ETH ADA].freeze
  CRYPTO_PROFIT = { "BTC" => 0.05, "ETH" => 0.042, "ADA" => 0.01 }

  validates :amount, presence: true

  monetize :amount_cents

  def crypto_amount
    (amount.dollars / rate.to_f).to_f.round(8)
  end

  def profit_usd
    (amount.dollars * (1 + CRYPTO_PROFIT[crypto])**12).round(2)
  end

  def profit_crypto
    (crypto_amount * (1 + CRYPTO_PROFIT[crypto])**12).round(8)
  end
end
