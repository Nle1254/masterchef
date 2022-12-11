CREATE DATABASE michelin;
grant all privileges on michelin.* to 'webapp'@'%';
flush privileges;

USE michelin;

CREATE TABLE restaurant(
  restaurantid integer NOT NULL AUTO_INCREMENT,
  email varchar(45) NOT NULL,
  pw varchar(45) NOT NULL,
  restaurant_name varchar(45) NOT NULL,
  street varchar(45) NOT NULL,
  city varchar(45) NOT NULL,
  restaurant_st varchar(45) NOT NULL,
  zipcode varchar(45) NOT NULL,
  num_stars integer NOT NULL,
  genreid integer NOT NULL,
  phone_number varchar(45) NOT NULL,
  reviewid integer DEFAULT NULL,
  restaurant_description mediumtext,
  menutypeid integer NOT NULL,
  PRIMARY KEY (restaurantid),
  UNIQUE KEY phone_number_UNIQUE (phone_number)
);

CREATE TABLE review (
  reviewid integer NOT NULL AUTO_INCREMENT,
  num_stars integer NOT NULL,
  review_description longtext NOT NULL,
  criticid integer NOT NULL,
  restaurantid integer NOT NULL,
  PRIMARY KEY (reviewid),
  KEY fk_review_restaurant1_idx (restaurantid),
  CONSTRAINT fk_review_restaurant1 FOREIGN KEY (restaurantid) REFERENCES restaurant (restaurantid)
);

CREATE TABLE critic(
  criticid integer NOT NULL AUTO_INCREMENT,
  email varchar(45) NOT NULL,
  username varchar(45) NOT NULL,
  pw varchar(45) NOT NULL,
  reviews_given integer NOT NULL,
  restaurantid integer NOT NULL,
  reviewid integer NOT NULL,
  PRIMARY KEY (criticid),
  KEY fk_critic_restaurant1_idx (restaurantid),
  KEY fk_critic_review1_idx (reviewid),
  CONSTRAINT fk_critic_restaurant1 FOREIGN KEY (restaurantid) REFERENCES restaurant (restaurantid),
  CONSTRAINT fk_critic_review1 FOREIGN KEY (reviewid) REFERENCES review (reviewid)
);

CREATE TABLE customer (
  customerid integer NOT NULL AUTO_INCREMENT,
  first_name varchar(45) DEFAULT NULL,
  last_name varchar(45) DEFAULT NULL,
  email varchar(45) NOT NULL,
  pw varchar(45) NOT NULL,
  street_address varchar(45) DEFAULT NULL,
  city varchar(45) DEFAULT NULL,
  st varchar(45) DEFAULT NULL,
  PRIMARY KEY (customerid)
);


CREATE TABLE critic_has_customer (
  critic_criticid integer NOT NULL AUTO_INCREMENT,
  customer_customerid integer NOT NULL,
  PRIMARY KEY (critic_criticid,customer_customerid),
  KEY fk_critic_has_customer_customer1_idx (customer_customerid),
  KEY fk_critic_has_customer_critic1_idx (critic_criticid),
  CONSTRAINT fk_critic_has_customer_critic1 FOREIGN KEY (critic_criticid) REFERENCES critic (criticid),
  CONSTRAINT fk_critic_has_customer_customer1 FOREIGN KEY (customer_customerid) REFERENCES customer (customerid)
); 


CREATE TABLE menutype (
  menutypeid integer NOT NULL,
  menutype_name varchar(45) DEFAULT NULL,
  PRIMARY KEY (menutypeid)
);

CREATE TABLE drink_type (
  drink_typeid integer NOT NULL,
  drink_type_name varchar(45) NOT NULL,
  PRIMARY KEY (drink_typeid),
  UNIQUE KEY name_UNIQUE (drink_type_name)
);
CREATE TABLE drink_menu (
  drink_menuid integer NOT NULL,
  menutypeid integer NOT NULL,
  PRIMARY KEY (drink_menuid),
  KEY fk_drink_menu_menutype1_idx (menutypeid),
  CONSTRAINT fk_drink_menu_menutype1 FOREIGN KEY (menutypeid) REFERENCES menutype (menutypeid)
);

CREATE TABLE drink_menu_items (
  drink_menu_itemsid integer NOT NULL,
  drink_typeid integer NOT NULL,
  drink_menuid integer NOT NULL,
  drink_menu_item_name varchar(45) NOT NULL,
  drink_menu_item_description mediumtext NOT NULL,
  price integer NOT NULL,
  PRIMARY KEY (drink_menu_itemsid),
  KEY fk_drink_menu_items_drink_type1_idx (drink_typeid),
  KEY fk_drink_menu_items_drink_menu1_idx (drink_menuid),
  CONSTRAINT fk_drink_menu_items_drink_menu1 FOREIGN KEY (drink_menuid) REFERENCES drink_menu (drink_menuid),
  CONSTRAINT fk_drink_menu_items_drink_type1 FOREIGN KEY (drink_typeid) REFERENCES drink_type (drink_typeid)
);


CREATE TABLE genre (
  genreid integer NOT NULL,
  food_type varchar(45) NOT NULL,
  restaurantid integer NOT NULL,
  PRIMARY KEY (genreid),
  UNIQUE KEY food_type_UNIQUE (food_type),
  KEY fk_genre_restaurant1_idx (restaurantid),
  CONSTRAINT fk_genre_restaurant1 FOREIGN KEY (restaurantid) REFERENCES restaurant (restaurantid)
);



CREATE TABLE regular_menu (
  regular_menuid integer NOT NULL,
  regular_menu_itemsid integer DEFAULT NULL,
  menutypeid integer NOT NULL,
  PRIMARY KEY (regular_menuid),
  KEY fk_regular_menu_menutype1_idx (menutypeid),
  CONSTRAINT fk_regular_menu_menutype1 FOREIGN KEY (menutypeid) REFERENCES menutype (menutypeid)
);

CREATE TABLE regular_menu_items (
  regular_menu_itemsid integer NOT NULL AUTO_INCREMENT,
  regular_menu_items_name varchar(45) NOT NULL,
  regular_menu_items_description mediumtext NOT NULL,
  price integer NOT NULL,
  regular_menuid integer NOT NULL,
  PRIMARY KEY (regular_menu_itemsid),
  KEY fk_regular_menu_items_regular_menu1_idx (regular_menuid),
  CONSTRAINT fk_regular_menu_items_regular_menu1 FOREIGN KEY (regular_menuid) REFERENCES regular_menu (regular_menuid)
);


CREATE TABLE set_menu(
  set_menuid integer NOT NULL,
  set_menu_name varchar(45) NOT NULL,
  price integer NOT NULL,
  menutypeid integer NOT NULL,
  PRIMARY KEY (set_menuid),
  KEY fk_set_menu_menutype1_idx (menutypeid),
  CONSTRAINT fk_set_menu_menutype1 FOREIGN KEY (menutypeid) REFERENCES menutype (menutypeid)
);

CREATE TABLE set_menu_items (
  set_menu_itemsid integer NOT NULL,
  set_menu_items_name varchar(45) NOT NULL,
  set_menu_items_description mediumtext NOT NULL,
  set_menuid integer NOT NULL,
  PRIMARY KEY (set_menu_itemsid),
  KEY fk_set_menu_items_set_menu1_idx (set_menuid),
  CONSTRAINT fk_set_menu_items_set_menu1 FOREIGN KEY (set_menuid) REFERENCES set_menu (set_menuid)
);

CREATE TABLE restaurant_has_customer (
  restaurant_restaurantid integer NOT NULL,
  customer_customerid integer NOT NULL,
  PRIMARY KEY (restaurant_restaurantid,customer_customerid),
  KEY fk_restaurant_has_customer_customer1_idx (customer_customerid),
  KEY fk_restaurant_has_customer_restaurant1_idx (restaurant_restaurantid),
  CONSTRAINT fk_restaurant_has_customer_customer1 FOREIGN KEY (customer_customerid) REFERENCES customer (customerid),
  CONSTRAINT fk_restaurant_has_customer_restaurant1 FOREIGN KEY (restaurant_restaurantid) REFERENCES restaurant (restaurantid)
);

CREATE TABLE restaurant_has_menutype (
  restaurant_restaurantid integer NOT NULL,
  menutype_menutypeid integer NOT NULL,
  PRIMARY KEY (restaurant_restaurantid,menutype_menutypeid),
  KEY fk_restaurant_has_menutype_menutype1_idx (menutype_menutypeid),
  KEY fk_restaurant_has_menutype_restaurant1_idx (restaurant_restaurantid),
  CONSTRAINT fk_restaurant_has_menutype_menutype1 FOREIGN KEY (menutype_menutypeid) REFERENCES menutype (menutypeid),
  CONSTRAINT fk_restaurant_has_menutype_restaurant1 FOREIGN KEY (restaurant_restaurantid) REFERENCES restaurant (restaurantid)
);

insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (1, 'restaurant@admin.com', 'admin', 'Alinea', '10 Downing Street', 'Lawrenceville', 'GA', '30045', 3, 5, '7703998943', 9, 'Chef Grant Achatz draws foodies with New American tasting menus featuring highly creative plates.', 1);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (2, 'rpayne1@auda.org.au', 'WGEBOmdEFy', 'Carbone', '1600 Pennsylvania Avenue', 'Atlanta', 'GA', '30356', 1, 9, '4043586154', 6, 'A cozy seafood spot located on the waterfront, offering fresh catches and a laid-back atmosphere.', 7);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (3, 'bmathey2@wix.com', 'ifREF49gH1o', 'Lupa', '1 Infinite Loop', 'Jefferson City', 'MO', '65110', 2, 2, '5731225895', 7, 'A trendy, upscale restaurant with a focus on innovative, avant-garde dishes.', 2);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (4, 'mstolli3@yale.edu', 'lUf0wl', 'Rao', '742 Evergreen Terrace', 'Birmingham', 'AL', '35236', 2, 4, '2052612662', 5, 'A chic, intimate dining experience specializing in high-end, modern interpretations of classic dishes.', 3);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (5, 'ablackmoor4@goo.ne.jp', '6aX41Cb226B5', 'The Whitlock', '221B Baker Street', 'Cleveland', 'OH', '44191', 1, 10, '2167490035', 3, 'A vibrant bistro known for its lively atmosphere and delicious international cuisine.', 1);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (6, 'cdethloff5@qq.com', 'V98kf0YPNx', 'Southern Table', '100 Universal City Plaza', 'Newport News', 'VA', '23612', 3, 3, '7571953889', 17, 'A bustling café with a menu of healthy, locally-sourced meals and a warm, inviting atmosphere.', 2);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (7, 'rbachanski6@constantcontact.com', 'dPAjSPVF', 'Blue Ribbon', '4 Privet Drive, Little Whinging', 'Sioux Falls', 'SD', '57188', 1, 6, '6054499457', 8, 'Modern upscale with a wide variety of tapas.', 3);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (8, 'kmerrien7@ask.com', '9CrJJ0', 'Umami', '1 Times Square', 'Redwood City', 'CA', '94064', 2, 3, '6502551525', 1, 'A quirky, out-of-this-world restaurant with a menu of extraterrestrial-inspired dishes.', 1);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (9, 'nbignold8@sogou.com', '4kqWidZK', 'Sugarfish', '1600 Amphitheatre Parkway', 'Raleigh', 'NC', '27610', 1, 2, '9191546094', 8, 'A high-class restaurant with a menu of traditional, refined dishes and a opulent atmosphere.', 2);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (10, 'mseagar9@prlog.org', 'CnM1Tki', 'Bibble & Sip', '1700 North Moore Street', 'Honolulu', 'HI', '96835', 2, 10, '8087322307', 15, 'A trendy, industrial-chic restaurant known for its unique takes on comfort food classics.', 3);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (11, 'mclementuccia@discuz.net', 'QKeU82', 'Fresco', '1111 North 11th Street', 'Hollywood', 'FL', '33023', 1, 8, '9545397589', 1, 'A retro diner with a laid-back atmosphere and a menu of classic American comfort food.', 1);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (12, 'gnockoldsb@census.gov', 'eGWgZJQqSwAm', 'Momo', '25 Golden Square', 'El Paso', 'TX', '79994', 2, 9, '9154159274', 3, 'A bright, airy café with a menu of fresh, citrus-inspired dishes and a sunny patio.', 2);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (13, 'wkehirc@istockphoto.com', 'q7mbx8HsL', 'Los Tacos', '1 World Trade Center', 'Arlington', 'VA', '22212', 2, 2, '5716715753', 11, 'A seafood paradise, offering a menu of fresh, sustainably-sourced catches.', 3);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (14, 'ldevericksd@usatoday.com', '2Q97xBfd', 'Pollo Royale', '3400 Peachtree Road NE', 'Tucson', 'AZ', '85720', 3, 8, '5201972655', 17, 'A peaceful, elegant restaurant known for its extensive selection of teas and delicate sandwiches and pastries.', 1);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (15, 'kberarde@bizjournals.com', 'Gh2UOJaXE', 'Los Pollos Hermanos', '1 Kennedy Space Center', 'Tallahassee', 'FL', '32309', 2, 6, '8509369702', 6, 'A beloved, family-owned restaurant known for its welcoming atmosphere and classic, hearty dishes.', 2);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (16, 'olacerf@digg.com', 'CHMQdJxh2', 'Joe and Son', '100 Museum Drive', 'Charlotte', 'NC', '28225', 1, 5, '7049910285', 13, 'A plant-based restaurant with a focus on fresh, organic ingredients and a vibrant atmosphere.', 3);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (17, 'sslopierg@networkadvertising.org', 'CPd6VKd4liIF', 'Jumbo House', '909 Ninth Street', 'Fairbanks', 'AK', '99790', 2, 4, '9074538377', 13, 'A whimsical, nostalgic spot known for its delicious, hand-crafted ice cream and other frozen treats.', 1);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (18, 'alarciereh@de.vu', 'qF7SPVWvzquY', 'Crazy Good Kitchen', '1 Austin Road West', 'Houston', 'TX', '77080', 3, 3, '8329972578', 11, 'A cozy, comforting restaurant known for its classic, soul-satisfying dishes and warm atmosphere.', 3);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (19, 'wchretieni@imgur.com', 'Pe47CEVjP405', 'Terra', '123 Main Street', 'Oklahoma City', 'OK', '73173', 2, 4, '4052741676', 11, 'A lively, interactive restaurant where guests can cook their own food in a boiling pot of broth at their table.', 2);
insert into restaurant (restaurantid, email, pw, restaurant_name, street, city, restaurant_st, zipcode, num_stars, genreid, phone_number, reviewid, restaurant_description, menutypeid) values (20, 'hturmallj@seattletimes.com', 'TbCFeQdsX', 'Grand Royale', '456 Park Avenue', 'Arvada', 'CO', '80005', 2, 9, '3036160059', 18, 'A farm-to-table restaurant with a focus on fresh, locally-sourced ingredients and a homey, welcoming atmosphere.', 3);

insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (1, 3, 'I recently had the pleasure of dining at this restaurant, and it was truly a remarkable experience. From the moment we arrived, we were treated like royalty. The service was impeccable - our every need was attended to, and the waitstaff were knowledgeable and attentive. The food was simply divine. Each dish was beautifully presented, and the flavors were truly exceptional. Every bite was a burst of flavor, and the chefs clearly put a great deal of care and attention into each dish. The presentation was also stunning - every plate looked like a work of art.', 1, 1);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (2, 0, 'The food was inconsistent throughout the night.', 2, 2);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (3, 2, 'As always, the food was wonderfly creative and consistent.', 3, 3);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (4, 3, 'One of the best dining experiences of my lifetime.', 4, 4);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (5, 2, 'It was wonderful.', 5, 5);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (6, 3, 'Mid.', 6, 6);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (7, 2, 'Very good.', 7, 7);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (8, 1, 'Awful. ', 8, 8);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (9, 1, 'Meh.', 9, 9);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (10, 2, 'Incredible.', 10, 10);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (11, 3, 'Perfection.', 11, 11);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (12, 3, 'Perfection', 12, 12);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (13, 1, 'Incredible.', 13, 13);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (14, 2, 'Super good.', 14, 14);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (15, 2, 'Better than last time.', 15, 15);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (16, 3, 'Perfection.', 16, 16);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (17, 1, 'Tasty.', 17, 17);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (18, 1, 'Average at best.', 18, 18);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (19, 2, 'Perfection.', 19, 19);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (20, 1, 'In hac habitasse platea dictumst.', 20, 20);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (21, 3, 'Truly consistent.', 1, 1);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (22, 3, 'Absolutely delightful.', 1, 2);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (23, 0, 'Awful.', 2, 1);
insert into review (reviewid, num_stars, review_description, criticid, restaurantid) values (24, 0, 'Awful.', 2, 3);


insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (1, 'critic@admin.com', 'critic_admin', 'pass', 2, 17, 1);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (2, 'bvannuccinii1@tmall.com', 'gus_fring', 'wdXVXj', 13, 5, 2);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (3, 'wpoulglais2@telegraph.co.uk', 'wolverine', 'GfKYcKm', 15, 16, 3);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (4, 'loakenfall3@scribd.com', 'ebellwood3', 'q3q6LNVK0mUc', 3, 16, 4);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (5, 'gcoxen4@deviantart.com', 'nphilott4', 'sFt0JBq4Y', 9, 2, 5);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (6, 'nibotson5@yellowpages.com', 'vgimeno5', '4DKzRh', 4, 2, 6);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (7, 'oivanyushkin6@thetimes.co.uk', 'twoollends6', '0AU6yu5mjV', 11, 14, 7);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (8, 'tbossons7@wufoo.com', 'mmendes7', 'mgiZ5DSvrfg', 11, 16, 8);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (9, 'lclemendot8@dion.ne.jp', 'bsevitt8', '2dokMgKMnocJ', 3, 11, 9);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (10, 'tkilmister9@qq.com', 'tgilhouley9', '14R31X', 5, 19, 10);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (11, 'sdovestona@multiply.com', 'tkedwarda', 'hUDF33', 9, 9, 11);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (12, 'pmagogb@fastcompany.com', 'benglishb', 'mgOAjaGGyVB', 6, 14, 12);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (13, 'vdunkirkc@economist.com', 'lcablec', '11tjM78Q', 13, 10, 13);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (14, 'jbortolazzid@senate.gov', 'kcarncrossd', 'hIbluWWmaf', 9, 12, 14);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (15, 'knansone@histats.com', 'lovette', 'Tjfk7g', 8, 3, 15);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (16, 'toshirinef@yahoo.com', 'vscheuf', '4B0GJc1QIf', 14, 16, 16);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (17, 'grockallg@latimes.com', 'dbalazing', 'LJVmwoBF47P7', 14, 5, 17);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (18, 'aornelash@craigslist.org', 'amacterrellyh', 'ZTrNh5Jv', 19, 5, 18);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (19, 'dforlongi@arstechnica.com', 'gschultzei', 'Kop9BlLkd', 10, 3, 19);
insert into critic (criticid, email, username, pw, reviews_given, restaurantid, reviewid) values (20, 'dtaltonj@elegantthemes.com', 'bzimekj', 'zePVZ2p', 17, 12, 20);


insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (1, 'Jane', 'Doe', 'customer@admin.com', 'admin', '07820 Corscot Pass', 'Worcester', 'MA');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (2, 'Jere', 'Chesterton', 'jchesterton1@ucoz.com', 'oLZaiT63hm8', '0 Monument Terrace', 'Albany', 'NY');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (3, 'Corinne', 'Stritton', 'cstritton2@barnesandnoble.com', 'TNbOEbopu', '4734 Stoughton Way', 'Jackson', 'MS');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (4, 'Harold', 'Boxall', 'hboxall3@omniture.com', 'Kcmh1VYR', '86824 Jenifer Street', 'Grand Junction', 'CO');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (5, 'Billie', 'Morrieson', 'bmorrieson4@w3.org', '6I6W2ap', '47043 8th Junction', 'New York City', 'NY');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (6, 'Pincus', 'Springtorpe', 'pspringtorpe5@cnet.com', 'Lg1WDNusus', '1 Spaight Drive', 'Hampton', 'VA');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (7, 'Jaime', 'Cawood', 'jcawood6@howstuffworks.com', 'HQdWRrXarjjd', '1 Packers Center', 'Hicksville', 'NY');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (8, 'Jaime', 'Midlar', 'jmidlar7@ucoz.com', 'GV14al9', '268 East Center', 'Savannah', 'GA');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (9, 'Constantine', 'Braywood', 'cbraywood8@webnode.com', 'LyzJIxUVRz', '66 Sugar Place', 'Columbus', 'OH');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (10, 'Neala', 'Gaul', 'ngaul9@imdb.com', 'spHwJUu', '5 Banding Crossing', 'Albuquerque', 'NM');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (11, 'Rab', 'Worthing', 'rworthinga@ca.gov', 'Afa6NiEYqhi8', '4 Sunfield Hill', 'Miami', 'FL');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (12, 'Maighdiln', 'Lilleyman', 'mlilleymanb@statcounter.com', 'WPtNiLmda7b3', '9486 Lien Terrace', 'Plano', 'TX');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (13, 'Kacey', 'Berrane', 'kberranec@liveinternet.ru', 'A8KQB6i6', '262 Monica Plaza', 'Winter Haven', 'FL');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (14, 'Valentine', 'Conyers', 'vconyersd@ucla.edu', '58jgxwty', '567 Superior Junction', 'Panama City', 'FL');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (15, 'Viviene', 'Benfell', 'vbenfelle@vistaprint.com', 'uKSxz4', '67733 Trailsway Parkway', 'Tuscaloosa', 'AL');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (16, 'Bertie', 'Stredwick', 'bstredwickf@pcworld.com', 'lWU3Qmv', '0859 Parkside Circle', 'Duluth', 'GA');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (17, 'Reyna', 'Matteo', 'rmatteog@ehow.com', 'hipE2V3X5W', '24153 Amoth Hill', 'Fresno', 'CA');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (18, 'Keary', 'Hearthfield', 'khearthfieldh@theglobeandmail.com', 'odbjqj', '70 Trailsway Way', 'Charlotte', 'NC');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (19, 'Gaylor', 'Huot', 'ghuoti@europa.eu', '691QCUMUraAL', '12 Hoard Street', 'Topeka', 'KS');
insert into customer (customerid, first_name, last_name, email, pw, street_address, city, st) values (20, 'Honoria', 'Cavet', 'hcavetj@wunderground.com', 'E9sF3mcQXg', '4 Coolidge Street', 'Youngstown', 'OH');

insert into menutype (menutypeid, menutype_name) values (1, 'set_menu');
insert into menutype (menutypeid, menutype_name) values (2, 'regular_menu');
insert into menutype (menutypeid, menutype_name) values (3, 'drink_menu');

insert into drink_type (drink_typeid, drink_type_name) values (1, 'whiskey');
insert into drink_type (drink_typeid, drink_type_name) values (2, 'rum');
insert into drink_type (drink_typeid, drink_type_name) values (3, 'gin');
insert into drink_type (drink_typeid, drink_type_name) values (4, 'soda');
insert into drink_type (drink_typeid, drink_type_name) values (5, 'vodka');
insert into drink_type (drink_typeid, drink_type_name) values (6, 'cocktail');
insert into drink_type (drink_typeid, drink_type_name) values (7, 'wine');
insert into drink_type (drink_typeid, drink_type_name) values (8, 'brandy');
insert into drink_type (drink_typeid, drink_type_name) values (9, 'beer');
insert into drink_type (drink_typeid, drink_type_name) values (10, 'tequila');
insert into drink_type (drink_typeid, drink_type_name) values (11, 'sake');


insert into drink_menu (drink_menuid, menutypeid) values (1, 1);
insert into drink_menu (drink_menuid, menutypeid) values (2, 1);
insert into drink_menu (drink_menuid, menutypeid) values (3, 1);
insert into drink_menu (drink_menuid, menutypeid) values (4, 1);
insert into drink_menu (drink_menuid, menutypeid) values (5, 1);
insert into drink_menu (drink_menuid, menutypeid) values (6, 1);
insert into drink_menu (drink_menuid, menutypeid) values (7, 1);
insert into drink_menu (drink_menuid, menutypeid) values (8, 1);
insert into drink_menu (drink_menuid, menutypeid) values (9, 1);
insert into drink_menu (drink_menuid, menutypeid) values (10, 1);



insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (1, 6, 6, 'velit', 'pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat', 34);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (2, 3, 5, 'quisque erat eros', 'amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor eu pede', 119);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (3, 1, 10, 'dui maecenas', 'condimentum id luctus nec molestie', 24);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (4, 1, 2, 'libero quis orci', 'fringilla rhoncus mauris enim leo rhoncus sed', 80);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (5, 7, 10, 'ultricies eu', 'amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis', 34);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (6, 5, 7, 'quam pede lobortis ligula', 'porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet', 150);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (7, 1, 1, 'amet diam in magna', 'volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut', 32);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (8, 4, 2, 'sodales scelerisque mauris sit amet', 'curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat', 120);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (9, 4, 10, 'in faucibus orci luctus', 'semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam', 155);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (10, 3, 8, 'morbi non', 'libero non mattis pulvinar nulla pede ullamcorper', 88);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (11, 1, 9, 'lectus pellentesque at nulla', 'pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac', 91);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (12, 6, 2, 'ipsum', 'amet eros suspendisse accumsan tortor quis turpis sed ante', 128);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (13, 7, 10, 'varius ut', 'nulla ac enim in tempor', 105);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (14, 7, 9, 'lorem', 'platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat', 129);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (15, 4, 5, 'enim leo rhoncus', 'maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum', 36);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (16, 8, 6, 'turpis', 'praesent lectus vestibulum quam sapien varius ut', 38);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (17, 4, 10, 'ac nibh fusce lacus', 'velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium', 186);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (18, 5, 1, 'quam turpis adipiscing lorem', 'mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra', 91);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (19, 1, 11, 'posuere', 'dolor vel est donec odio justo sollicitudin', 159);
insert into drink_menu_items (drink_menu_itemsid, drink_menuid, drink_typeid, drink_menu_item_name, drink_menu_item_description, price) values (20, 6, 3, 'scelerisque quam turpis adipiscing', 'sapien in sapien iaculis congue vivamus', 95);


insert into genre (genreid, food_type, restaurantid) values (1, 'Chinese', 1);
insert into genre (genreid, food_type, restaurantid) values (2, 'Japanese', 2);
insert into genre (genreid, food_type, restaurantid) values (3, 'French', 3);
insert into genre (genreid, food_type, restaurantid) values (4, 'Colombian', 4);
insert into genre (genreid, food_type, restaurantid) values (5, 'American', 5);
insert into genre (genreid, food_type, restaurantid) values (6, 'Korean', 6);
insert into genre (genreid, food_type, restaurantid) values (7, 'Vietnamese', 7);
insert into genre (genreid, food_type, restaurantid) values (8, 'Indian', 8);
insert into genre (genreid, food_type, restaurantid) values (9, 'Italian', 9);
insert into genre (genreid, food_type, restaurantid) values (10, 'Thai', 10);


insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (1, 4, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (2, 15, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (3, 60, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (4, 59, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (5, 39, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (6, 1, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (7, 67, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (8, 19, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (9, 20, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (10, 94, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (11, 17, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (12, 39, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (13, 4, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (14, 44, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (15, 88, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (16, 33, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (17, 61, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (18, 37, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (19, 42, 3);
insert into regular_menu (regular_menuid, regular_menu_itemsid, menutypeid) values (20, 88, 3);

insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (1, 'The All-American Burger', 'A juicy, hearty burger made with a 100% beef patty and topped with all the classic fixings: lettuce, tomato, onion, pickles, and ketchup.', 50, 1);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (2, 'The Perfect Pizza', 'cheesy pizza made with the freshest ingredients and cooked to perfection in a wood-fired oven.', 80, 2);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (3, 'The Classic Pasta Dish', 'The Classic Pasta Dish is a comforting, flavorful dish made with your choice of pasta and sauce.', 65, 3);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (4, 'The Ultimate Sandwich', '  a hearty, satisfying sandwich made with your choice of bread, meat, cheese, and toppings.', 40, 4);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (5, 'Crispy Fried Chicken', ' a Southern favorite made with juicy, marinated chicken that is breaded and fried to crispy perfection.', 70, 5);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (6, 'The Fresh and Healthy Salad', 'a refreshing, nutritious salad made with a variety of fresh greens, vegetables, and toppings.', 70, 6);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (7, 'The Ultimate Nacho Experience', 'a delicious, satisfying plate of nachos made with tortilla chips, melted cheese, and all your favorite toppings.', 15, 7);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (8, 'Authentic Tacos al Pastor', 'Mexican tacos made with marinated pork that is grilled and served on a corn tortilla with onions, cilantro, and pineapple.', 100, 8);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (9, 'Hearty and Comforting Soup', ' a warm, satisfying soup made with your choice of broth, vegetables, and protein.', 120, 9);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (10, 'The Perfectly Grilled Steak', 'a juicy, flavorful steak that is grilled to your desired level of doneness and topped with your choice of sauce or seasoning.', 90, 10);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (11, 'Traditional Fish and Chips', 'a British classic made with crispy fried fish and thick-cut chips, served with tartar sauce and malt vinegar.', 80, 11);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (12, 'Flavorful Fried Rice', 'made with cooked rice that is stir-fried with vegetables and protein.', 70, 12);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (13, 'Delicious Fried Noodles', 'satisfying dish made with your choice of noodles that are stir-fried with vegetables and protein.', 59, 13);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (14, 'Homemade Meatloaf', ' home-style dish made with ground beef and a blend of seasonings, topped with a tangy tomato glaze.', 60, 14);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (15, 'Crispy Chicken Fingers', 'kid-friendly favorite made with breaded and fried chicken strips that are served with your choice of dipping sauce.', 50, 15);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (16, 'Spicy Buffalo Wings', 'crispy chicken wings that are coated in a spicy hot sauce and served with a side of blue cheese dressing for dipping.', 50, 16);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (17, 'Kid-Friendly Chicken Nuggets', 'bite-sized pieces of breaded and fried chicken that are perfect for dipping in your favorite sauce.', 40, 17);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (18, 'The Classic Grilled Cheese', 'a simple yet satisfying sandwich made with melted cheese on grilled white bread.', 50, 18);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (19, 'The Original Caesar Salad', 'crisp salad made with romaine lettuce, croutons, parmesan cheese, and a tangy Caesar dressing.', 70, 19);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (20, 'Rich and Creamy Lobster Bisque', 'luxurious soup made with a base of rich seafood stock and chunks of succulent lobster meat.', 80, 20);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (21, 'The All-American Burger', 'A juicy, hearty burger made with a 100% beef patty and topped with all the classic fixings: lettuce, tomato, onion, pickles, and ketchup.', 50, 2);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (22, 'Wagyu Steak', 'A5 Wagyu served with rice.', 300, 1);
insert into regular_menu_items (regular_menu_itemsid, regular_menu_items_name, regular_menu_items_description, price, regular_menuid) values (23, 'Truffle Fries', 'Curly fries served with white truffle shavings.', 50, 1);

insert into set_menu (set_menuid, set_menu_name, price, menutypeid) values (1, 'turpis integer aliquet', 372, 2);
insert into set_menu (set_menuid, set_menu_name, price, menutypeid) values (2, 'morbi sem mauris', 340, 2);
insert into set_menu (set_menuid, set_menu_name, price, menutypeid) values (3, 'diam in magna bibendum', 415, 2);
insert into set_menu (set_menuid, set_menu_name, price, menutypeid) values (4, 'lacus morbi sem mauris ', 452, 2);
insert into set_menu (set_menuid, set_menu_name, price, menutypeid) values (5, 'risus praesent lectus vestibulum', 409, 2);
insert into set_menu (set_menuid, set_menu_name, price, menutypeid) values (6, 'et ultrices posuere', 496, 2);
insert into set_menu (set_menuid, set_menu_name, price, menutypeid) values (7, 'porttitor pede justo', 435, 2);
insert into set_menu (set_menuid, set_menu_name, price, menutypeid) values (8, 'consectetuer eget', 180, 2);
insert into set_menu (set_menuid, set_menu_name, price, menutypeid) values (9, 'non mattis pulvinar', 149, 2);
insert into set_menu (set_menuid, set_menu_name, price, menutypeid) values (10, 'lobortis', 492, 2);

insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (1, 'luctus et ultrices posuere', 'lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse', 8);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (2, 'amet lobortis sapien', 'nunc rhoncus dui vel sem sed sagittis', 1);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (3, 'ut rhoncus aliquet pulvinar sed nisl', 'vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum', 7);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (4, 'nulla ut erat id mauris', 'lorem integer tincidunt ante vel', 1);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (5, 'amet consectetuer', 'ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed', 5);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (6, 'praesent lectus vestibulum', 'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede', 1);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (7, 'orci vehicula condimentum curabitur in libero', 'turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in', 7);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (8, 'volutpat convallis morbi odio', 'quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in', 6);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (9, 'sit amet consectetuer adipiscing', 'eu magna vulputate luctus cum', 2);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (10, 'felis donec semper sapien a libero', 'eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin', 6);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (11, 'sollicitudin mi sit amet', 'in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in', 2);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (12, 'placerat praesent', 'lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum', 1);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (13, 'dolor quis odio consequat varius integer', 'luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec', 2);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (14, 'vestibulum sit', 'mauris eget massa tempor convallis nulla neque libero convallis', 2);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (15, 'quam pede lobortis ligula sit', 'nulla suscipit ligula in lacus curabitur at ipsum ac tellus', 2);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (16, 'at vulputate vitae nisl aenean lectus', 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus', 2);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (17, 'in felis', 'vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo', 6);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (18, 'non ligula pellentesque', 'turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu', 2);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (19, 'felis fusce posuere felis', 'ut at dolor quis odio consequat', 2);
insert into set_menu_items (set_menu_itemsid, set_menu_items_name, set_menu_items_description, set_menuid) values (20, 'justo nec condimentum neque sapien placerat', 'rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui', 6);
