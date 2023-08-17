import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  onInput(e) {
    clearTimeout(this.typingTimer);

    this.typingTimer = setTimeout(this.convertToCrypto, 200, e.target.value);
  }

  onChange(e) {
    const amountUSD = transaction_amount.value

    console.log(amountUSD)

    this.convertToCrypto(amountUSD)
  }

  async convertToCrypto(amount) {
    const CRYPTO_PROFIT = { BTC: 0.05, ETH: 0.042, ADA: 0.01 }

    const cryptoSymbol = transaction_crypto.value

    if (!amount) {
      convertion.innerText = `0 ${cryptoSymbol}`

      return
    }

    const response = await fetch("https://data.messari.io/api/v1/assets?fields=slug,symbol,metrics/market_data/price_usd");
    const responseJson = await response.json();

    const currency = responseJson.data.find(currency => currency.symbol === cryptoSymbol)
    const priceUSD = currency.metrics.market_data.price_usd

    const amountUSD = parseFloat(amount)

    const amountCrypto = (amountUSD / priceUSD).toFixed(8)

    const profitUSD = (amountUSD * (1 + CRYPTO_PROFIT[cryptoSymbol])**12).toFixed(2)
    const profitCrypto = (profitUSD / priceUSD).toFixed(8)

    convertion.innerText = `${amountCrypto} ${cryptoSymbol}`
    profit.innerText = `$${profitUSD} - ${profitCrypto}`
  }
}
