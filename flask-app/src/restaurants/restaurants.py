from flask import Blueprint, request, jsonify, make_response
import json
from src import db


restaurants = Blueprint('restaurants', __name__)

# Get all customers from the DB
@restaurants.route('/restaurants', methods=['GET'])
def get_restaurants():
    cursor = db.get_db().cursor()
    cursor.execute('select * from restaurant')
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
@restaurants.route('/restaurants/name/<userID>', methods=['GET'])
def get_restaurant_name(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select restaurant_name from restaurant where restaurantid = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@restaurants.route('/restaurants/email/<userID>', methods=['GET'])
def get_restaurant_email(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select email from restaurant where restaurantid = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@restaurants.route('/review/<reviewID>', methods=['GET'])
def get_review(reviewID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from review where reviewid = {0}'.format(reviewID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@restaurants.route('/genre', methods=['GET'])
def get_genre():
    cursor = db.get_db().cursor()
    cursor.execute('select * from genre')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@restaurants.route('/restaurants/get_genreid/<restaurantID>', methods=['GET'])
def get_genre_id(restaurantID):
    cursor = db.get_db().cursor()
    cursor.execute('select genreid from restaurant where restaurantid = {0}'.format(restaurantID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@restaurants.route('/restaurants/get_food_type/<genreID>', methods=['GET'])
def get_genre_name(genreID):
    cursor = db.get_db().cursor()
    cursor.execute('select food_type from genre where genreid = {0}'.format(genreID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


@restaurants.route('/restaurants/rating/<userID>', methods=['GET'])
def get_restaurant_rating(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select num_stars from restaurant where restaurantid = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@restaurants.route('/restaurants/address/<userID>', methods=['GET'])
def get_restaurant_address(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select street, city, restaurant_st from restaurant where restaurantid = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@restaurants.route('/restaurants/genre/<userID>', methods=['GET'])
def get_restaurant_genre(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select genreid restaurant where restaurantid = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response