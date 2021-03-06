# StockCalculator
[![Build Status](https://travis-ci.org/kibitan/stock_calculator.svg?branch=master)](https://travis-ci.org/kibitan/stock_calculator)
[![Maintainability](https://api.codeclimate.com/v1/badges/bfc7ca7e931335b59b69/maintainability)](https://codeclimate.com/github/kibitan/stock_calculator/maintainability)
[![codecov](https://codecov.io/gh/kibitan/stock_calculator/branch/master/graph/badge.svg)](https://codecov.io/gh/kibitan/stock_calculator)

Input stock symbol and a start date, calculate the rate of return and maximum drawdown of the stock since the start date to today.

## Installation

```bash
 $ git clone git@github.com:kibitan/stock_calculator.git
 $ bin/setup
```

You can use [direnv](https://direnv.net/) as well.

## Requirement

 * Ruby 2.4.2

 * You need [Quandl API key](https://docs.quandl.com/docs#section-authentication), set it to environment variable `QUANDL_API_KEY`.

 * For notifying Slack you need [Incoming Webhook URL](https://get.slack.help/hc/en-us/articles/115005265063-Incoming-WebHooks-for-Slack), set it to environment variable `SLACK_WEBHOOK_URL`.

## Usage

```
 $ stock_calculator execute STOCK_SYMBOL START_DATE
```

e.g.

```
 $ stock_calculator execute AAPL 2017-12-03
Stock Symbol: AAPL
Date: 2017-12-03 ~ 2017-12-07

Rate of return: -2.012%
Maximum Drawdown: 3.568%
Notified to Slack!
```

## Run test

```
 $ bundle exec rspec
```

## TODO
 - [ ] write integration test
 - [ ] implement more error handling e.g. Timeout
 - [ ] implement more notifier
 - [ ] optionize notifier
 - [ ] notify with prices graph e.g. [Image Charts](https://image-charts.com/documentation#!/chart/getChart)
 - [ ] add another metrics e.g.
 - [ ] compatible with another countries e.g. Tokyo stock exchange
 - [ ] make easier executable e.g. publish to Rubygems

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kibitan/stock_calculator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the StockCalculator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kibitan/stock_calculator/blob/master/CODE_OF_CONDUCT.md).
