class TransactionsController < ApplicationController

  def create
    # debugger
    @transaction = Transaction.new(transaction_params)
    @transaction.rate = current_rate
    @transaction.save

    redirect_to root_path
  end

  private

  def transaction_params
    params.require(:transaction).permit(:crypto, :amount)
  end

  def current_rate
    url = 'https://data.messari.io/api/v1/assets?fields=slug,symbol,metrics/market_data/price_usd'
    request = Faraday.get(url)
    response = JSON.parse(request.body)
    data_response = response['data'].find { |slug| slug['symbol'] == params[:transaction][:crypto] }

    data_response['metrics']['market_data']['price_usd']
  end
end
