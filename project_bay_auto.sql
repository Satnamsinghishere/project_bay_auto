/*
Project
Satnam Singh
*/

/*Create a database*/
CREATE DATABASE bay_auto;

/*Make a database my current database*/
USE bay_auto;

/*Create a customer table*/
CREATE TABLE customer_T (
cust_id int(6) AUTO_INCREMENT not null,
cust_name varchar(30) not null,
cust_phone varchar(14) not null,
cust_address varchar(50) not null,
cust_city varchar(20) not null,
cust_state varchar(2) not null,
cust_zipcode varchar(5) not null,
CONSTRAINT customer_pk PRIMARY KEY (cust_id));

/*Create a vehicles table*/
CREATE TABLE vehicles_T (
Veh_id int(11) auto_increment not null,
Veh_name varchar(20) not null,
Veh_model varchar(10) not null,
Veh_trim varchar(10) not null,
Veh_make varchar(10) not null,
cust_id int(11) not null,
CONSTRAINT vehicles_pk PRIMARY KEY (Veh_id, cust_id),
constraint vehicles_fk foreign key(cust_id) references customer_T(cust_id)
on update cascade on delete restrict);

/*Create a insurance_rep table*/
CREATE TABLE insurance_rep_T (
repair_id int(11) AUTO_INCREMENT not null,
repair_name varchar(50) not null,
repair_company varchar(50) not null,
repair_phone varchar(14) not null,
repair_location varchar(10) not null,
cust_id int(11) not null,
CONSTRAINT insurance_rep_pk PRIMARY KEY (repair_id, cust_id),
constraint insurance_rep_fk foreign key(cust_id) references customer_T(cust_id)
on update cascade on delete restrict);

/*Create a location table*/
CREATE TABLE location_T (
location_id int(1) AUTO_INCREMENT not null,
location_city varchar(20) not null,
location_address varchar(20) not null,
CONSTRAINT location_pk PRIMARY KEY (location_id));

/*Create a employees table*/
CREATE TABLE employee_T (
employee_id int(11) AUTO_INCREMENT not null,
employee_name varchar(40) not null,
employee_phone varchar(14) not null,
employee_address varchar(50) not null,
employee_city varchar(20) not null,
employee_state varchar(15) not null,
employee_zipcode varchar(5) not null,
employee_department int(10),
employee_type_full_time varchar(10) not null,
employee_type_hourly varchar(10) not null,
repair_id int(11) not null,
location_id int(11) not null,
CONSTRAINT employee_pk PRIMARY KEY (employee_id, repair_id, location_id),
constraint employee_fk1 foreign key(repair_id) references insurance_rep_T(repair_id)
on update cascade on delete restrict,
constraint employee_fk2 foreign key(location_id) references location_T(location_id)
on update cascade on delete restrict);

/*Create a services table*/
CREATE TABLE services_T (
serv_id int(11) AUTO_INCREMENT not null,
serv_date date not null,
serv_time varchar(10) not null,
serv_price int(10) not null,
serv_type_repair varchar(10) not null,
serv_type_body varchar(10) not null,
serv_type_paint varchar(10) not null,
employee_id int(11),
Veh_id int(11),
CONSTRAINT services_pk PRIMARY KEY (serv_id, employee_id, Veh_id),
constraint services_fk1 foreign key(employee_id) references employee_T(employee_id)
on update cascade on delete restrict,
constraint services_fk2 foreign key(Veh_id) references vehicles_T(Veh_id)
on update cascade on delete restrict);

/*Create a billing table*/
CREATE TABLE billing_T (
bill_id int(11) AUTO_INCREMENT not null,
bill_date date not null,
serv_time varchar(10) not null,
serv_price int(10) not null,
serv_type_repair varchar(10) not null,
serv_type_body varchar(10) not null,
serv_type_paint varchar(10) not null,
serv_id int(11) not null,
cust_id int(11) not null,
CONSTRAINT billing_pk PRIMARY KEY (bill_id, serv_id, cust_id),
constraint billing_fk1 foreign key(serv_id) references services_T(serv_id)
on update cascade on delete restrict,
constraint billing_fk2 foreign key(cust_id) references customer_T(cust_id)
on update cascade on delete restrict);

/*Create a vendor table*/
CREATE TABLE vendor_T (
ven_id int(11) AUTO_INCREMENT not null,
ven_name varchar(20) not null,
ven_phone varchar(14) not null,
ven_address varchar(50) not null,
location_id int(11) not null,
CONSTRAINT vendor_pk PRIMARY KEY (ven_id, location_id),
constraint vendor_fk foreign key(location_id) references location_T(location_id)
on update cascade on delete restrict);

/*Create a supplies table*/
CREATE TABLE supplies_T (
sup_id int(11) AUTO_INCREMENT not null,
sup_desc varchar(20) not null,
sup_unit_avail int(10) not null,
sup_cost_per_unit int(10) not null,
ven_id int(11) not null,
CONSTRAINT supplies_pk PRIMARY KEY (sup_id, ven_id),
constraint supplies_fk foreign key(ven_id) references vendor_T(ven_id)
on update cascade on delete restrict);

/*Create a parts table*/
CREATE TABLE part_T (
unit_id int(11) AUTO_INCREMENT not null,
unit_price int(5) not null,
unit_avail int(10) not null,
part_new varchar(10) not null,
part_used varchar(10) not null,
serv_id int(11) not null,
ven_id int(11) not null,
CONSTRAINT part_pk PRIMARY KEY (unit_id, serv_id, ven_id),
constraint part_fk1 foreign key(serv_id) references services_T(serv_id)
on update cascade on delete restrict,
constraint part_fk2 foreign key(ven_id) references vendor_T(ven_id)
on update cascade on delete restrict);

INSERT INTO customer_T (cust_id,cust_name,cust_phone,cust_address,cust_city,cust_state,cust_zipcode)
VALUES
  ("674859","Lucy Joyce","(181) 574-0253","P.O. Box 361, 9582 Lorem, St.","Richmond","CA","94801"),
  ("748954","Leo Hughes","(382) 316-7592","218-5704 Ac Rd.","Richmond","CA","94801"),
  ("859904","Brian Coffey","(865) 966-1231","124-3856 Sed Rd.","Oakland","CA","94501"),
  ("845948","Leonard Dodson","(502) 901-4057","9234 Cras Avenue","Oakland","CA","94501"),
  ("245637","Shellie Mooney","(610) 781-8535","1720 Eleifend Avenue","Berkeley","CA","94701"),
  ("859384","Simon Sears","(468) 785-7764","392-8632 Magna. Street","Berkeley","CA","94701"),
  ("599402","Sade Pace","(276) 524-7639","950-5748 Sagittis Road","San Leandro","CA","94577"),
  ("584905","Yoshio Byrd","(164) 137-0726","Ap #633-3314 Leo. Avenue","San Leandro","CA","94577"),
  ("379788","Stacy Kennedy","(523) 937-8958","294-2361 Erat Street","Hayward","CA","94540"),
  ("748590","Iona Spence","(428) 222-8878","Ap #802-2176 Tellus. St.","Hayward","CA","34388");

/*SELECT * FROM customer_T;*/

INSERT INTO location_T (location_city, location_address)
VALUES
("Hayward","1200 Valley View Rd"),
("Oakland","403 Colliseum Dr"),
("Richmond","12232 San Pablo Ave"),
("San Leandro","3492 Heroes Blvd"),
("Berkeley","3940 Telegraph Ave");

/*SELECT * FROM location_T*/

INSERT INTO insurance_rep_T (repair_name, repair_company, repair_phone,repair_location,cust_id)
VALUES
("Farmer, Finn K.","Odio Semper Company","1-543-736-7969","1","674859"),
("Robles, Richard X.","Ultrices LLP","1-765-776-1772","1","748954"),
("Jordan, Alden J.","Laoreet Lectus Consulting","1-859-266-0143","2","859904"),
("Cooley, Tatyana A.","Quis Diam Corp.","1-242-270-4773","2","845948"),
("Walter, Emmanuel L.","Vestibulum Mauris Associates","1-668-527-3407","3","245637"),
("Rowe, Alisa B.","Vel Pede Blandit Foundation","1-846-485-4127","3","859384"),
("Long, Veronica T.","Arcu Corp.","1-582-503-6555","4","599402"),
("Sawyer, Angelica R.","Elit Pede","1-602-313-1433","4","584905"),
("Holloway, Kelsie K.","Eget Nisi Limited","1-914-718-6989","5","379788"),
("Meadows, Jada I.","Consequat Dolor Vitae Incorporated","1-836-344-3375","5","748590");

/*SELECT * FROM insurance_rep_T*/

INSERT INTO vehicles_T (Veh_name, Veh_model, Veh_trim, Veh_make, cust_id)
VALUES
("Honda Civic","Civic","LX","Honda","674859"),
("Honda Accord","Accord","EX","Honda","748954"),
("Toyota Civic","Civic","LX","Toyota","859904"),
("Honda Accord","Accord","EX","Honda","845948"),
("Honda Civic","Civic","LX","Honda","245637"),
("Toyota Accord","Accord","EX","Toyota","859384"),
("Honda Civic","Civic","LX","Honda","599402"),
("Honda Accord","Accord","EX","Honda","379788"),
("Toyota Civic","Civic","LX","Toyota","748590"),
("Honda Accord","Accord","EX","Honda","584905");

/*SELECT * FROM vehicles_T;*/

INSERT INTO employee_T (employee_name, employee_phone, employee_address, employee_city, employee_state, employee_zipcode, employee_type_full_time, employee_type_hourly, repair_id, location_id)
VALUES
("Herring, Indira F.", "1-740-362-7668", "4689 Dolor Street", "Oakland", "CA", "94501", "Yes", "No","1","1"),
("Williamson, Nicholas M.", "1-654-853-6217", "1922 Maecenas St.", "Richmond", "CA", "94801", "Yes", "No","2","1"),
("Underwood, Roary H.","1-626-817-8733","9852 Lorem Road","Hayward", "CA","62506","Yes","No","3","2"),
("Spears, Ashely I.","1-456-712-8417","1662 Amet Avenue","Hayward", "CA","72265","No","Yes","4","2"),
("Terrell, Charissa N.","1-181-962-2132","2866 Nonummy St.","Richmond","CA","94801","No","Yes","5","3"),
("Deleon, Salvador J.","1-655-258-2268","7857 Eu, St.","Oakland","CA","94501","Yes","No","6","3"),
("Whitehead, Rana O.","1-628-416-5101","2115 Pellentesque St.","Berkeley","CA","94701","No","Yes","7","4"),
("Jones, Talon T.","1-153-426-5913","4223 Dui. St.","San Leandro","CA","94577","Yes","No","8","4"),
("Sutton, Kelsey P.","1-484-779-9537","1912 Ut St.","San Leandro","CA","94577","Yes","No","9","5"),
("Alston, Harrison Y.","1-571-816-5318","6496 Luctus, St.","Berkeley","CA","94701","No","Yes","10","5");

SELECT * FROM employee_T;

INSERT INTO services_T (serv_date,serv_time,serv_price,serv_type_repair,serv_type_body,serv_type_paint,employee_id,Veh_id)
VALUES
  ("2021/07/10","2:04 PM","300", "Y","Y","N","1","1"),
  ("2021/01/15","7:37 AM","100", "Y","Y","N","2","2"),
  ("2021/02/10","2:46 PM","120","N","N","Y","3","3"),
  ("2021/02/20","12:41 PM","800","Y","N","Y","4","4"),
  ("2021/03/15","10:10 PM","388","N","N","Y","5","5"),
  ("2021/04/16","11:00 PM","483","Y","N","Y","6","6"),
  ("2021/05/11","3:43 AM","482","N","N","Y","7","7"),
  ("2021/06/06","8:15 AM","876","N","N","Y","8","8"),
  ("2021/07/01","9:00 PM","433","Y","N","N","9","9"),
  ("2021/08/04","8:52 PM","748","Y","N","N","10","10");
  
/*SELECT * FROM services_T;*/

INSERT INTO billing_T (bill_date,serv_time,serv_price,serv_type_repair,serv_type_body,serv_type_paint,serv_id,cust_id)
VALUES
  ("2021/07/10","2:04 PM","300", "Y","Y","N","1","674859"),
  ("2021/01/15","7:37 AM","100", "Y","Y","N","2","748954"),
  ("2021/02/10","2:46 PM","120","N","N","Y","3","859904"),
  ("2021/02/20","12:41 PM","800","Y","N","Y","4","845948"),
  ("2021/03/15","10:10 PM","388","N","N","Y","5","245637"),
  ("2021/04/16","11:00 PM","483","Y","N","Y","6","859384"),
  ("2021/05/11","3:43 AM","482","N","N","Y","7","599402"),
  ("2021/06/06","8:15 AM","876","N","N","Y","8","584905"),
  ("2021/07/01","9:00 PM","433","Y","N","N","9","379788"),
  ("2021/08/04","8:52 PM","748","Y","N","N","10","748590");

/*SELECT * FROM billing_T;*/


INSERT INTO vendor_T (ven_name, ven_phone, ven_address, location_id)
VALUES
 ("Forrest Ewing","1-812-465-6423","2174 Cras St.","1"),
 ("Penelope Olsen","(781) 733-4164","5361 Cursus Street","1"),
 ("Alvin Carney","1-418-434-7801","7291 Aliquet Street","2"),
 ("Hoyt Riddle","1-338-413-0771","773-4807 Consequat Street","2"),
 ("Acton Campbell","(662) 394-7144","2019 Ipsum. Road","3"),
 ("Jason Orr","1-632-715-2024","6464 Lectus. Road","3"),
 ("Caldwell Olson","(813) 826-4967","7151 Condimentum St.","4"),
 ("Lois Hartman","(788) 896-0223","6441 Lorem Rd.","4"),
 ("Leilani Morrison","1-549-983-2364","1286 Orci. St.","5"),
 ("Carissa Russell","(822) 690-9760","Ap #401-5337 In Road","5");

/*SELECT * FROM vendor_T;*/

INSERT INTO supplies_T (sup_desc, sup_unit_avail, sup_cost_per_unit, ven_id)
VALUES
  ("paint", "3","20","1"),
  ("tool", "4", "90", "2"),
  ("paint", "5","81","3"),
  ("tool", "3","84","4"),
  ("paint", "4","65","5"),
  ("paint", "3", "100","6"),
  ("tool", "5", "91","7"),
  ("tool", "7", "68","8"),
  ("paint","8", "58","9"),
  ("paint","5","10","10");

/*SELECT * FROM supplies_T;*/

INSERT INTO part_T (unit_price, unit_avail, part_new, part_used, serv_id, ven_id)
VALUES
  ("68","52","Y","N","1","2"),
  ("56","45","N","Y","2","1"),
  ("41","36","Y","N","3","4"),
  ("20","9","Y","N","4","3"),
  ("9","67","Y","N","5","6"),
  ("68","12","N","Y","7","6"),
  ("55","4","Y","N","8","7"),
  ("19","32","N","Y","3","6"),
  ("18","74","Y","N","9","10"),
  ("11","1","N","Y","8","9");

/*SELECT * FROM part_T;*/

/*Query 1*/
SELECT * FROM customer_T, vehicles_T
WHERE customer_T.cust_id = vehicles_T.cust_id;

/*Query 2*/
SELECT * FROM customer_T, billing_T
WHERE customer_T.cust_id = billing_T.cust_id;

/*Query 3*/
/*INNER JOIN*/
SELECT * FROM customer_T INNER JOIN billing_T
ON customer_T.cust_id = billing_T.cust_id
WHERE serv_type_repair = "Y";

/*Query 4*/
/*INNER JOIN*/
SELECT * FROM location_T INNER JOIN employee_T
ON employee_T.location_id = location_T.location_id
WHERE location_T.location_id = "1";

/*q5*/
SELECT customer_T.cust_id, cust_name, bill_id, bill_date
FROM customer_T LEFT OUTER JOIN billing_T
ON customer_T.cust_id = billing_T.cust_id;

/*view 1*/
CREATE VIEW v_invoice AS
SELECT customer_T.cust_id, cust_name, bill_id, bill_date
FROM customer_T, billing_T
WHERE customer_T.cust_id = billing_T.cust_id
AND customer_T.cust_id = "584905";

/*view 2*/
CREATE VIEW v_employee2 AS
SELECT employee_id, employee_name, location_city, location_address
FROM employee_T, location_T
WHERE employee_T.location_id = location_T.location_id
AND location_T.location_id = "2";