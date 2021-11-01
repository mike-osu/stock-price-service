import yfinance as yf


def lambda_handler(event, context):
    """
    Get stock info based on 'ticker' querystring parameter
    """
    ticker = event['queryStringParameters']['ticker']
    stock_info = yf.Ticker(ticker)
    df = stock_info.history(period="1d")
    payload = df.to_json(orient='records')
    
    response = {
        "statusCode": 200,
        "headers": { "Content-Type": "application/json"},
        "body": payload
    }

    print(response)
    return response


if __name__ == '__main__':
    lambda_handler(None, None)