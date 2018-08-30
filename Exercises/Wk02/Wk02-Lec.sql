CREATE SEQUENCE orders_order#_seq
  INCREMENT BY 1
  START WITH 1021
  NOCACHE
  NOCYCLE;
  
SELECT *
  FROM user_sequences;
  
INSERT INTO orders (order#, customer#, orderdate, shipdate, shipstreet, shipcity, shipstate, shipzip)
  VALUES (orders_order#_seq.NEXTVAL, 1010, '06-APR-09', NULL, '123 WEST MAIN', 'ATLANTA', 'GA', 30418);
  
INSERT INTO orderitems (order#, item#, isbn, quantity, paideach)
  VALUES (orders_order#_seq.CURRVAL, 1, 8117949391, 1, 8.50);
  
SELECT *
  FROM orders JOIN orderitems USING(order#)
    WHERE customer# = 1010;
    
    
    
CREATE SEQUENCE test_defval_seq
  INCREMENT BY 1
  START WITH 100
    NOCACHE
    NOCYCLE;

CREATE TABLE test_defval
  (col1 NUMBER DEFAULT test_defval_seq.NEXTVAL,
   col2 NUMBER);
   
   
   
ALTER SEQUENCE orders_order#_seq
  INCREMENT BY 10;
  
DROP SEQUENCE orders_order#_seq;  
  
SELECT *
  FROM user_sequences;  
  
  
  
CREATE TABLE test_ident
  (col1 NUMBER GENERATED AS IDENTITY PRIMARY KEY,
   col2 NUMBER);
   
INSERT INTO test_ident (col2)
  VALUES (350);
INSERT INTO test_ident (col1, col2)
  VALUES (225, 355);  
INSERT INTO test_ident (col1, col2)
  VALUES (DEFAULT, 360);  
  
  
  
  
  
CREATE INDEX customers_zip_idx
  ON customers (zip);
  
CREATE INDEX customers_name_idx
  ON customers (lastname, firstname);
  
  
  
SELECT customer#, lastname, city, state, zip
  FROM customers
  WHERE zip = 49006;
  
  
  
  
  
  
CREATE BITMAP INDEX customers_region_idx
  ON customers (region);
  
  
CREATE INDEX books_profit_idx
  ON books (retail-cost);
  
  
  
  
  
CREATE TABLE books2
(ISBN VARCHAR2(10),
 title VARCHAR2(30),
 pubdate DATE,
 pubID NUMBER(2),
 cost NUMBER(5,2),
 retail NUMBER(5,2),
 category VARCHAR2(12),
  CONSTRAINT books2_isbn_pk PRIMARY KEY(isbn))
ORGANIZATION INDEX;



SELECT table_name, index_name, index_type
  FROM user_indexes
    WHERE table_name = 'CUSTOMERS';
    
SELECT table_name, index_name, column_name
  FROM user_ind_columns
    WHERE table_name = 'CUSTOMERS';  
    
SELECT *
  FROM user_indexes
    WHERE table_name = 'BOOKS2';
    
DROP INDEX books2_title_idx;

CREATE INDEX books2_title_idx
  ON books2 (title);
  
  
  
  
  
CREATE SYNONYM bookbuyers
  FOR customers;
  
SELECT *
  FROM bookbuyers
  fetch first 8 rows only;
  
DROP SYNONYM bookbuyers;  