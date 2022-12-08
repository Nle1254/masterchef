from flask import Blueprint, request, jsonify, make_response
import json
from src import db


customers = Blueprint('customers', __name__)

# Get all customers from the DB
@customers.route('/customers', methods=['GET'])
def get_customers():
    cursor = db.get_db().cursor()
    cursor.execute('select * from customer')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get customer detail for customer with particular userID
@customers.route('/customers_f/<custID>', methods=['GET'])
def get_customerf(custID):
    cursor = db.get_db().cursor()
    cursor.execute('select first_name from customer where customerid = {0}'.format(custID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


@customers.route('/customers_l/<custID>', methods=['GET'])
def get_customerl(custID):
    cursor = db.get_db().cursor()
    cursor.execute('select last_name from customer where customerid = {0}'.format(custID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response