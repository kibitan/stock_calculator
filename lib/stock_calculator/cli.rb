module StockCalculator
  require 'thor'

  class Cli < ::Thor
    desc 'execute STOCK_SYMBOL START_DATE', 'calculate rate of return, maximum drawdown and notify result'
    options verbose: :boolean
    def execute(stock_symbol, start_date)
      StockCalculator.run(
        {
          stock_symbol: stock_symbol,
          start_date: start_date,
          verbose: options[:verbose]
        }.compact
      )

    # Input
    rescue StockCalculator::InvalidDate
      $stderr.puts 'invalid start date'
    rescue StockCalculator::OutOfDate
      $stderr.puts 'start date should be up to today'

    # Quandl
    rescue StockCalculator::Quandl::NoAPIKey
      $stderr.puts 'please set Quandl API key to environment variable QUANDL_API_KEY'
    rescue StockCalculator::Quandl::NoData
      $stderr.puts 'No stock data, please check stock symbol/start date is correct'
    rescue StockCalculator::Quandl::InvalidAPIKey
      $stderr.puts 'Quandl API key is invalid, please check Quandl API key is correct'

    # Slack
    rescue StockCalculator::Notifier::Slack::NoWebhookUrl
      $stderr.puts 'for notifying Slack, please set Incoming Webhook URL to environment variable SLACK_WEBHOOK_URL'
    rescue StockCalculator::Notifier::Slack::InvalidUrl
      $stderr.puts 'Slack Incoming Webhook URL is not valid url, please check Incoming Webhook URL is correct'
    rescue StockCalculator::Notifier::Slack::APIError
      $stderr.puts 'failed to notify Slack, please check Incoming Webhook URL is correct'
    end
  end
end
