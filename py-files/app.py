from flask import Flask

app = Flask(__name__)



@app.route('/healthcheck')
def hc():
    return 'Health Check passed'


@app.route('/')
def hello_world():
    return 'Hello World'





if __name__ == '__main__':

    run_config = {
        "debug": True,
        "host": "0.0.0.0",
        "port": 5000
    }
    app.run(**run_config)

