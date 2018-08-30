SELECT LOWER(firstname), LOWER(lastname), SUBSTR(lastname, -5, 1)
  FROM customers;  
  
  
  
  
  
SELECT title, MONTHS_BETWEEN(orderdate, pubdate) Months
  FROM books JOIN orderitems USING(isbn)
    JOIN orders USING(order#);
    
SELECT title, ROUND(MONTHS_BETWEEN(orderdate, pubdate), 2) AS "Months Gap"
  FROM books JOIN orderitems USING(isbn)
    JOIN orders USING(order#);    
    
SELECT title, TRUNC(MONTHS_BETWEEN(pubdate, orderdate), 0) AS "Months Gap"
  FROM books JOIN orderitems USING(isbn)
    JOIN orders USING(order#);    
    
    
    
    
SELECT title, pubdate, ADD_MONTHS(SYSDATE, -1) "rANDOM dATE"
  FROM books;
  
  
  
  
  
SELECT order#, shipdate, NVL2(shipdate, 'SHIPPED', 'NOT SHIPPED')
  FROM orders;
  
  
  
  
  
SELECT customer#, state,
  DECODE(state, 'CA', .08,
                'FL', .07,
                        0) "Sales Tax Rate"
  FROM customers
    WHERE state IN('CA', 'FL', 'GA', 'TX');