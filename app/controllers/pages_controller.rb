class PagesController < ApplicationController

  def home
    @transaction = Transaction.new
    @btc_transaction = Transaction.where(crypto: "BTC")
    @eth_transaction = Transaction.where(crypto: "ETH")
    @ada_transaction = Transaction.where(crypto: "ADA")
  end
end
