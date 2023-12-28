class CurrencyExchangeService
  def self.get_exchange_rate
    response = HTTP.get('https://mindicador.cl/api/dolar')
    data = JSON.parse(response)

    data['serie'][0]['valor']
  end

  def self.convert_to_usd(amount, clp_to_usd_rate)
    amount / clp_to_usd_rate
  end

  def self.convert_to_clp(amount, usd_to_clp_rate)
    amount * usd_to_clp_rate
  end
end