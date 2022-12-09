from flask import Blueprint, request, jsonify, make_response
import json
from src import db
from flask import current_app


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


#------------------MENU ITEMS   -----------------------------#
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

@restaurants.route('/get_drink_menu', methods=['GET'])
def get_drink_menu():
    cursor = db.get_db().cursor()
    cursor.execute('select * from drink_menu_items')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

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
    return "Success!"

"""
@app.route('/critics_insertdata', method = ['POST'])
def add_review():
    current_app.logger.info(request.form)
    cursor = db_connection.get_db().cursor()
    num_stars = request.form['num_stars']
    review_description = request.form['review_description']
    critic_id = request.form['critic_id']
    restaurant_id = request.form['rest_id']
    query = f'INSERT INTO review(num_stars, review_description, criticid, restaurantid) VALUES(\"{num_stars}\", \"{review_description}\", \"{critic_id}\", \"{restaurant_id}\")'
    cursor.execute(query)
    db_connection.get_db().commit()
    return "Success!"

@app.route('/critics/username', method = ['GET'])
def get_critic_username():
    current_app.logger.info(request.form)
    cursor = db_connection.get_db().cursor()
    cursor.execute('select username from critic')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    return jsonify(json_data)
"""