# Dan Buckle - Patchwork Test

## How to start

### Docker

First way to start is to run the app via docker using the normal `docker-compose build` command followed by `docker-compose up`

### Locally

This is running on ruby 2.7.2 and will start with `rails s` command

## Endpoints

`/nomics/ticker`

| Parameter Name | Param Type | Parameter Description |
| ------------- | ------------- | ------------- |
| tickers[] | ARRAY |  List of tickers e.g BTC,ETH,XRP  |
| fields  | STRING | List of fields only to return e.g circulating_supply, max_supply, name, symbol, price  |
| convert  | STRING | String of currency you want to specific fiat to e.g USD  |


`/nomics/exchange`

| Parameter Name | Parameter Type | Parameter Description |
| ------------- | ------------- | ------------- |
| current_from | STRING |  First currency you want exchange rate of  |
| current_to  | STRING | Second currency you want exchange rate of  |
