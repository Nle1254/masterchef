from flask import Blueprint, request, jsonify, make_response
import json
from src import db
from flask import current_app


restaurants = Blueprint('restaurants', __name__)

# Get all restaurants from the DB
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

# Get restaurant name for restaurant with particular ID
@restaurants.route('/restaurants/name/<restID>', methods=['GET'])
def get_restaurant_name(restID):
    cursor = db.get_db().cursor()
    cursor.execute('select restaurant_name from restaurant where restaurantid = {0}'.format(restID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all reviews of a specifc restaurant 
@restaurants.route('/review/<restID>', methods=['GET'])
def get_review_id(restID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from review where restaurantid = {0}'.format(restID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Get all reviews
@restaurants.route('/review', methods=['GET'])
def get_review():
    cursor = db.get_db().cursor()
    cursor.execute('select * from review')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Get all genres of food 
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

#Get the genreid of a specific restaurant
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


# Get the food type/genre name based on the genreID
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

# Get a restaurant's rating
@restaurants.route('/restaurants/rating/<restID>', methods=['GET'])
def get_restaurant_rating(restID):
    cursor = db.get_db().cursor()
    cursor.execute('select num_stars from restaurant where restaurantid = {0}'.format(restID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get the address of a restaurant
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


#------------------MENU ITEMS   -----------------------------#

# Get all regular menu items
@restaurants.route('/get_reg_menu', methods=['GET'])
def get_reg_menu_itmes():
    cursor = db.get_db().cursor()
    cursor.execute('select * from regular_menu_items')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

#get a specific restaurant's menu
@restaurants.route('/get_reg_menu/<restID>', methods=['GET'])
def get_reg_menu_itmes_spec(restID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from regular_menu_items where regular_menuid = {0}'.format(restID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Insert data into a restaurant's menu
@restaurants.route('/menu_insertdata', methods=['POST'])
def add_review():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    regular_menu_items_name = request.form['item_name']
    regular_menu_items_description = request.form['item_description']
    price = request.form['item_price']
    regular_menuid = request.form['restaurantid']
    query = f'INSERT INTO regular_menu_items(regular_menu_items_name, regular_menu_items_description, price, regular_menuid) VALUES(\"{regular_menu_items_name}\", \"{regular_menu_items_description}\", \"{price}\", \"{regular_menuid}\")'
    cursor.execute(query)
    db.get_db().commit()