from flask import Flask
from flask_cors import CORS, cross_origin
import random
import MySQLdb

app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

@app.route("/")
@cross_origin()
def hello():
    db = MySQLdb.connect(host="10.0.15.12", user="user", passwd="user", db="my_database")
    db.close()
    return "Hello  " + str(random.randint(0,100)) + " If this is visible the db works"

app.run(host="0.0.0.0")