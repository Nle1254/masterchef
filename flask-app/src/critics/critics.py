from flask import Blueprint, request, jsonify, make_response
import json
from src import db
from flask import current_app
from flask import logging


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


#get a critic's email
@critics.route('/critics/<email>', methods=['GET'])
def get_critic_email(email):
    cursor = db.get_db().cursor()
    cursor.execute('select email from critic where criticid = {0}'.format(email))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response



#get all of a specifc critic's info
@critics.route('/review/<critID>', methods=['GET'])
def get_reviews(critID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from review where criticid = {0}'.format(critID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Insert a review into the database
@critics.route('/critics_insertdata', methods=['POST'])
def add_review():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    num_stars = request.form['num_stars']
    review_description = request.form['review_description']
    criticid = request.form['criticid']
    restaurantid = request.form['restaurantid']
    query = f'INSERT INTO review(num_stars, review_description, criticid, restaurantid) VALUES(\"{num_stars}\", \"{review_description}\", \"{criticid}\", \"{restaurantid}\")'
    cursor.execute(query)
    db.get_db().commit()
