import logging
from flask import Flask, redirect, render_template
import psycopg2

app = Flask(__name__, static_folder='assets')
app.config["TEMPLATE_AUTO_RELOAD"] = True

import routes


def get_db_connection():
    conn = psycopg2.connect(host='100.115.92.203', database='ecom' user='hyperscaleios', password='changeme')
    app.logger.info('what the fuck')
    return conn

if __name__ == "__main__":
    logging.basicConfig(filename='fuck.log' , level=logging.DEBUG)
    app.run(debug=True)
