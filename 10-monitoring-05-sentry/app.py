import sentry_sdk
from flask import Flask

sentry_sdk.init(
    dsn="https://56838d4b2cabee5c23f1b7bef18fd2c6@o4506746363576320.ingest.sentry.io/4506746365870080",
    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    traces_sample_rate=1.0,
    # Set profiles_sample_rate to 1.0 to profile 100%
    # of sampled transactions.
    # We recommend adjusting this value in production.
    profiles_sample_rate=1.0,
)

app = Flask(__name__)

@app.route("/")
def hello_world():
    1/0  # raises an error
    return "<p>Hello, World!</p>"

if __name__ == "__main__":
    app.run(port=8080, host="0.0.0.0", debug=True)
    #app.run()
