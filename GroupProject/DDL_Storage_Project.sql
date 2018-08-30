/*CUSTOMER :: DONE*/

CREATE TABLE customer (
custID INT PRIMARY KEY NOT NULL,
fname VARCHAR(10) NOT NULL,
lname VARCHAR(10) NOT NULL,
phone VARCHAR(10) NOT NULL,
address VARCHAR(40) NOT NULL,
email VARCHAR(30) NOT NULL,
birthDate DATE NOT NULL,
store_credit DECIMAL(10,2) DEFAULT NULL, 
status CHAR(3) DEFAULT 'REG',
CONSTRAINT chk_status CHECK (status='REG' OR status='VIP')
);

CREATE SEQUENCE gen_custID START WITH 3000 INCREMENT BY 15;

/* CUSTOMER :: TRIGGER */
/* WORKS */
CREATE OR REPLACE TRIGGER trg_checkAge 
	BEFORE INSERT ON customer
	REFERENCING NEW AS temp_cust
	FOR EACH ROW 
	WHEN (YEAR(temp_cust.birthDate) + 18 >= YEAR(CURRENT_DATE))
	SIGNAL SQLSTATE '78000' SET MESSAGE_TEXT = 'Customer is too young!'
	
	
DROP TRIGGER chk_age;
	
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Dannel', 'Alon', '6479991212','21 Welsford Toronto', 'dalon@gmail.com','1995-10-29',0,'VIP');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Ethan', 'Cruise', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Bryan', 'Maravilla', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Victor', 'Marshal', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Tony', 'Ford', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Mao', 'Wong', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Sarah', 'Watson', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Rose', 'Spencer', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Charlie', 'Morgan', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Joseph', 'Cook', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Hillary', 'Clinton', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Donald', 'Trumo', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Bob', 'Smith', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Kevin', 'Stewart', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');
INSERT INTO customer VALUES (gen_custID.NEXTVAL, 'Daniela', 'Clinton', '6472335656', 'Le chamber #23 Montreal', 'eitan_alon@gmail.com', '2002-10-11', 0, 'REG');


/*ORDER ITEM :: DONE*/

CREATE TABLE order (
orderID INT PRIMARY KEY NOT NULL,
custID INT NOT NULL,
payID INT NOT NULL,
o_date DATE NOT NULL,
o_status CHAR(3) NOT NULL,
o_price DECIMAL(10,2) NOT NULL,
CONSTRAINT chk_status CHECK (o_status='PEN' OR o_status='APP' OR o_status='DEL'),
CONSTRAINT fk1_order FOREIGN KEY (custID) REFERENCES customer(custID),
CONSTRAINT fk2_order FOREIGN KEY (payID) REFERENCES method_payment(payID)
);
CREATE SEQUENCE gen_orderID START WITH 5000 INCREMENT BY 10;

/*ORDER ITEM*/

CREATE TABLE order_item (
orderID INT NOT NULL, 
prodID CHAR(10) NOT NULL,
o_qty INT NOT NULL, 
CONSTRAINT fk1_order_item FOREIGN KEY (orderID) REFERENCES order(orderID),
CONSTRAINT fk2_order_item FOREIGN KEY (prodID) REFERENCES product(prodID),
CONSTRAINT chk_o_qty CHECK (o_qty <= 5)
);

/*PRODUCT*/

CREATE TABLE product (
prodID VARCHAR(9) PRIMARY KEY NOT NULL,
brand VARCHAR(25) NOT NULL,
prod_name VARCHAR(25) UNIQUE NOT NULL,
type_name VARCHAR(20) NOT NULL, 
prod_price DECIMAL(10,2) DEFAULT 0.00,
p_qty INT DEFAULT 0
);
CREATE SEQUENCE num_prodID START WITH 100 INCREMENT BY 25 MAXVALUE 975;


CREATE TRIGGER gen_prodID
	AFTER INSERT ON product
	REFERENCING NEW AS temp_prod
	FOR EACH ROW
	BEGIN ATOMIC
	DECLARE A1 VARCHAR(3);--
	DECLARE A2 VARCHAR(2);--
	DECLARE B VARCHAR(3);--
	DECLARE C VARCHAR(3);--
	DECLARE ID VARCHAR(9);--
	SET A1 = UPPER(SUBSTR(temp_prod.brand,1,3));--
	SET B = UPPER(SUBSTR(temp_prod.prod_name,1,3));--
	SET C = CAST(num_prodID.NEXTVAL AS VARCHAR(3));--
	SET ID = A1 || B|| C;--
	UPDATE product SET prodID = ID WHERE brand = temp_prod.brand AND
	prod_name = temp_prod.prod_name;--
	END;

	
INSERT INTO product(prodID, brand, prod_name) VALUES (num_prodID.NEXTVAL, 'Apple', 'Macbook Pro');
INSERT INTO product(prodID, brand, prod_name) VALUES (num_prodID.NEXTVAL,'Dell', 'XPS 14');
INSERT INTO product(prodID, brand, prod_name) VALUES (num_prodID.NEXTVAL,'Apple', 'Iphone 6s');
INSERT INTO product(prodID, brand, prod_name) VALUES (num_prodID.NEXTVAL,'Samsung', 'Galaxy S7');
INSERT INTO product(prodID, brand, prod_name) VALUES (num_prodID.NEXTVAL,'Sony', 'PSP 2');


/*SHELF UNIT*/

CREATE TABLE shelf_unit (
shelfID VARCHAR(6) PRIMARY KEY NOT NULL,
empID INT,
prodID VARCHAR(9),
s_index INT NOT NULL, 
s_column INT NOT NULL, 
s_row INT NOT NULL,
CONSTRAINT chk_sindex CHECK (s_index > 0 AND s_index <= 20),
CONSTRAINT chk_scolumn CHECK (s_column > 0 AND s_column <= 6),
CONSTRAINT chk_srow CHECK (s_row > 0 AND s_row <= 4),
CONSTRAINT fk2_shelf_unit FOREIGN KEY (empID) REFERENCES employee(empID),
CONSTRAINT fk2_shelf_unit FOREIGN KEY (prodID) REFERENCES product(prodID) 
);
CREATE SEQUENCE temp_shelfid START WITH 1 INCREMENT BY 1 MAXVALUE 100;


INSERT INTO shelf_unit(s_index, s_column, s_row) VALUES(temp_shelfid.NEXTVAL, gen_column.NEXTVAL, gen_row.NEXTVAL);


INSERT INTO shelf_unit(shelfID, s_index, s_column, s_row) VALUES(temp_shelfid.NEXTVAL,9,1,2);
INSERT INTO shelf_unit(shelfID, s_index, s_column, s_row) VALUES(temp_shelfid.NEXTVAL,9,1,2);
INSERT INTO shelf_unit(shelfID, s_index, s_column, s_row) VALUES(temp_shelfid.NEXTVAL,10,1,2);
INSERT INTO shelf_unit(shelfID, s_index, s_column, s_row) VALUES(temp_shelfid.NEXTVAL,2,1,2);
INSERT INTO shelf_unit(shelfID, s_index, s_column, s_row) VALUES(temp_shelfid.NEXTVAL,20,1,2);

CREATE SEQUENCE temp_shelfid START WITH 1 INCREMENT BY 1 MAXVALUE 100;


CREATE TRIGGER gen_shelfID
	AFTER INSERT ON shelf_unit
	REFERENCING NEW AS temp_shelf
	FOR EACH ROW
	BEGIN ATOMIC
	DECLARE A VARCHAR(2);--
	DECLARE B VARCHAR(1);--
	DECLARE C VARCHAR(1);--
	DECLARE ID VARCHAR(6);--
	SET A = CAST(temp_shelf.s_index AS VARCHAR(2));--
	SET B = CAST(temp_shelf.s_column AS VARCHAR(1));--
	SET C = CAST(temp_shelf.s_row AS VARCHAR(1));--
	IF (temp_shelf.s_index < 10) THEN
	SET ID = '0' || A || '0' || B || '0' || C;--
	ELSE
	SET ID = A || '0' || B || '0' || C;--
	END IF;--
	UPDATE shelf_unit SET shelfID = ID WHERE s_index = temp_shelf.s_index AND
	s_column = temp_shelf.s_column AND s_row = temp_shelf.s_row;--
	END;

/*METHOD PAYMENT :: DONE*/

CREATE TABLE method_payment (
payID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 9000 INCREMENT BY 10),
custID INT NOT NULL,
method VARCHAR(10) NOT NULL,
cbrand VARCHAR(20),
cnum INT,
cname VARCHAR(30),
cexpDate DATE,
csecCode INT,
CONSTRAINT chk_method CHECK (method='Debit' OR method='Credit'),
CONSTRAINT fk1_method_payment FOREIGN KEY (custID) REFERENCES customer(custID)
);


/*SHIPPING*/

CREATE TABLE shipping (
shipID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 600 INCREMENT BY 10),
empID INT NOT NULL, 
ship_date DATE NOT NULL,
CONSTRAINT fk1_shipping FOREIGN KEY (empID) REFERENCES employee(empID)
);

/*SHIPPING RECORD*/

CREATE TABLE shipping_record (
shipID INT NOT NULL,
orderID INT UNIQUE NOT NULL,
ship_fee DECIMAL(10,2) NOT NULL, 
ship_location VARCHAR(70),
CONSTRAINT fk1_shipping_record FOREIGN KEY (shipID) REFERENCES shipping(shipID),
CONSTRAINT fk2_shipping_record FOREIGN KEY (orderID) REFERENCES order(orderID)
);

/*EMPLOYEE*/

CREATE TABLE employee (
empID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 400 INCREMENT BY 10),
name VARCHAR(15) NOT NULL,
section CHAR(2),
hireDate DATE NOT NULL,
discount DECIMAL(3,2) DEFAULT 0.00
);

CREATE TRIGGER gen_emp_disc
	AFTER INSERT ON employee
	REFERENCING NEW AS temp_emp
	FOR EACH ROW
	BEGIN ATOMIC
	DECLARE DISC DECIMAL(3,2);--
	SET DISC = 0.20;--
	IF (DAYS(CURRENT DATE) - DAYS(temp_emp.hireDate) >= 90) THEN
	UPDATE employee SET discount = DISC WHERE empID = temp_emp.empID;--
	END IF;--
	END;

INSERT INTO employee(name, section, hireDate) VALUES('Vicky', 'A1', '2016-04-01');
INSERT INTO employee(name, section, hireDate) VALUES('Jack', 'A1', '2016-01-01');
INSERT INTO employee(name, section, hireDate) VALUES('Bob', 'A1', '2015-12-01');

/*RETURNED PRODUCT*/

CREATE TABLE ret_product (
prodID CHAR(10) NOT NULL, 
orderID INT NOT NULL,
type_name VARCHAR(20) NOT NULL,
reason ENUM('Change', 'Defective'),
date_return TIMESTAMP NOT NULL
CONSTRAINT fk1_ret_product FOREIGN KEY (prodID) REFERENCES product(prodID),
CONSTRAINT fk2_ret_product FOREIGN KEY (orderID) REFERENCES order(orderID),
);


/*DEPOSIT*/

CREATE TABLE deposit (
depID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 500 INCREMENT BY 5)
custID INT NOT NULL,
orderID INT NOT NULL,
amount DECIMAL(10,2) NOT NULL,
CONSTRAINT fk1_deposit FOREIGN KEY (custID) REFERENCES customer(custID),
CONSTRAINT fk2_deposit FOREIGN KEY (orderID) REFERENCES order(orderID) 
);

