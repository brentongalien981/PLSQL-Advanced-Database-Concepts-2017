/* 1 */
--Housekeepings
SELECT *
  FROM user_sequences;
  
--
CREATE SEQUENCE customers_customer#_seq
  INCREMENT BY 1
  START WITH 1021
  NOCACHE
  NOCYCLE;
  
  
  
  
  
/*2*/
INSERT INTO customers (customer#, lastname, firstname, zip)
  VALUES (customers_customer#_seq.NEXTVAL, 'Shoulders', 'Frank', 23567);