from flask import Blueprint, request, jsonify, make_response
import json
from src import db
from flask import current_app


critics = Blueprint('critics', __name__)

# Get all the critics from the database
@critics.route('/critics', methods=['GET'])
def get_critics():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of critics
    cursor.execute('select criticid, username, email from critic')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# get the top 5 critics from the database
@critics.route('/top5critics')
def get_most_pop_critics():
    cursor = db.get_db().cursor()
    query = '''
        SELECT p.productCode, productName, sum(quantityOrdered) as totalOrders
        FROM critics p JOIN orderdetails od on p.productCode = od.productCode
        GROUP BY p.productCode, productName
        ORDER BY totalOrders DESC
        LIMIT 5;
    '''
    cursor.execute(query)
       # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@critics.route('/critics/<userID>', methods=['GET'])
def get_critic(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select email from critic where criticid = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@critics.route('/critics/<email>', methods=['GET'])
def get_critic_email(email):
    cursor = db.get_db().cursor()
    cursor.execute('select criticid from critic where email = {0}'.format(email))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@critics.route('/addreview', methods = ['POST'])
def add_review():
    current_app.logger.info(request.form)
    cur = db.get_db().cursor()
    num_stars = request.form['num_stars']
    review_description = request.form['review_description']
    criticid = request.form['criticid']
    resaurantid = request.form['restaurantid']
