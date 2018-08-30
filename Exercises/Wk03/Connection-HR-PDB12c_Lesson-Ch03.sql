SELECT * 
  FROM orderitems
  WHERE order# <= 1006;
  
SELECT SUM((paideach-cost) * quantity) AS "Total Profit"
  FROM orderitems JOIN books  USING (isbn)
  WHERE order# = 1007;
  
SELECT AVG(paideach)
  FROM orderitems;
  
SELECT COUNT(category)
  FROM books;
SELECT COUNT(DISTINCT category)
  FROM books;
  
SELECT COUNT(*) AS "Method COUNT()"
  FROM orders
  WHERE shipdate IS NOT NULL;
  
SELECT MAX(pubdate) AS "Latest Released Book"
  FROM books;
  
SELECT MIN(pubdate) AS "Earliest Released Book"
  FROM books;
  
SELECT category, TO_CHAR(AVG(retail-cost))
  FROM books
  GROUP BY category;
  
SELECT category, AVG(retail-cost) AS "Profit"
  FROM books
  GROUP BY category
  HAVING AVG(retail-cost) > 16;
  

SELECT * 
  FROM regions;
  
SELECT category, COUNT(category), TO_CHAR(AVG(retail-cost), '999.99999') AS "Profit"
  FROM books
  WHERE pubdate > '31-DEC-04'
  GROUP BY category
  HAVING AVG(retail-cost) > 15;
  
  
SELECT TO_CHAR(AVG(SUM(quantity * paideach)), '999.999') AS "Total Gross Per Customer Order"
  FROM orders JOIN orderitems USING (order#)
  --FROM orderitems
  GROUP BY order#;
  
  
  
SELECT category, MIN(retail-cost) AS "Min"
  FROM books
  GROUP BY category;
  
  
  
SELECT name, category, AVG(retail) AS "Avg Retail"
  FROM publisher JOIN books USING (pubid)
  WHERE pubid IN (2, 3, 5)
  GROUP BY GROUPING SETS((name, category), ());
  
  
  
SELECT title, retail, 
                     (SELECT TO_CHAR(AVG(retail), '999.999')
                        FROM books) AS "Avg Book Price"
  FROM books;
  
SELECT TO_CHAR(AVG(retail), '999.999') AS "Avg Book Price"
  FROM books;
  
  
  
SELECT  category, MAX(retail)
  FROM books
  GROUP BY category;
  
SELECT title, retail, category
  FROM books
  WHERE retail IN (SELECT MAX(retail)
                    FROM books
                    GROUP BY category) AND
    retail > 35
  ORDER BY category;
  
  
  
SELECT title, retail
  FROM books
  WHERE category = 'COOKING';
  
SELECT title, retail
  FROM books;
  
SELECT title, retail
  FROM books
  WHERE retail < ANY (SELECT retail
                      FROM books
                      WHERE category = 'COOKING');
                      
                      
                      
SELECT customer#, lastname, order#, item#, state
  FROM customers JOIN orders USING (customer#)
    JOIN orderitems USING (order#)
  WHERE state = 'FL';
  
SELECT order#,/*customer#, lastname, order#, item#, state,*/ SUM(quantity * paideach) AS "Total Order Cost"
  FROM customers JOIN orders USING (customer#)
    JOIN orderitems USING (order#)
  WHERE state = 'FL'
  GROUP BY order#;
  
SELECT SUM(quantity * paideach) --COUNT(*) 
  FROM orderitems
  WHERE (quantity * paideach) > 50
  GROUP BY order#;

SELECT SUM(quantity * paideach)
  FROM orderitems
  HAVING SUM(quantity * paideach) > ALL (SELECT SUM(quantity * paideach)
                                          FROM customers JOIN orders USING (customer#)
                                            JOIN orderitems USING (order#)
                                          WHERE state = 'FL'
                                          GROUP BY order#)
  GROUP BY order#;
  
  
  
SELECT category, AVG(retail) cataverage
  FROM books
  GROUP BY category;
  
SELECT b.title, b.retail, a.category, a.cataverage
  FROM books b, (SELECT category, AVG(retail) cataverage
                  FROM books
                  GROUP BY category) a
  WHERE b.category = a.category
    AND b.retail > a.cataverage
  ORDER BY a.category, b.retail;





SELECT category, MAX(retail)
  FROM books
  GROUP BY category
  ORDER BY category;
  
SELECT title, retail, category
  FROM books
  WHERE (category, retail) IN (SELECT category, MAX(retail)
                                FROM books
                                GROUP BY category)
  ORDER BY category;        
  
  
  
  
  
SELECT customer#, lastname, NVL(referred, 0)
  FROM customers;
  
SELECT customer#, referred
  FROM customers
  WHERE NVL(referred, 0) = (SELECT NVL(referred, 0)
                              FROM customers
                              WHERE customer# = 1005);
                              
SELECT COUNT(*)
  FROM customers
  WHERE referred IS NULL;
  
  
  
  
  
SELECT title
  FROM books
  WHERE EXISTS (SELECT isbn
                  FROM orderitems
                  WHERE books.isbn = orderitems.isbn);
                  
                  
                  
                  
                  
SELECT MAX(COUNT(*))                 
  FROM orderitems
  GROUP BY order#;
  
SELECT order#
  FROM orderitems
  GROUP BY order#
  HAVING COUNT(*) = 4;
  
SELECT customer#, lastname || ', '  || firstname AS "Name"
  FROM customers JOIN orders USING (customer#)
  WHERE order# IN (SELECT order#
                    FROM orderitems
                    GROUP BY order#
                    HAVING COUNT(*) = (SELECT MAX(COUNT(*))                 
                                        FROM orderitems
                                        GROUP BY order#));
                                        
                                        
                                        
                                        
                                        
MERGE INTO books_1 a
  USING books_2 b
    ON (a.isbn = b.isbn)
  WHEN MATCHED THEN
    UPDATE SET a.retail = b.retail,  a.category = b.category;
    
SELECT * 
  FROM books_1;
  
  