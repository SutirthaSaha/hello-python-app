import time

from flask import Flask
from prometheus_client import start_http_server, Summary, Gauge, Counter
from gevent.pywsgi import WSGIServer

app = Flask(__name__)
start_http_server(8000)

COUNT_OF_REQUESTS = Counter('request_count', 'Total number of requests')


@app.route("/")
def hello():
    COUNT_OF_REQUESTS.inc()
    return "Hello, World!"


if __name__ == "__main__":
    server = WSGIServer(('127.0.0.1', 5000), app)
    server.serve_forever()
