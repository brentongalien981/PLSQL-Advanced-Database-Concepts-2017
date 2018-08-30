-- Implicit Cursor
--BEGIN
--  UPDATE bb_product
--    SET stock = stock + 25
--    WHERE idProduct = 10;
--    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
--    
--  IF SQL%NOTFOUND THEN
--    DBMS_OUTPUT.PUT_LINE('Not Found');
--  END IF;
--END;




-- Explicit Cursor
--DECLARE
--  CURSOR cur_basket IS
--    SELECT bi.idBasket, p.type, bi.price, bi.quantity
--      FROM bb_basketitem bi INNER JOIN bb_product p
--        USING (idProduct)
--      WHERE bi.idBasket <= 10;
--      
--  TYPE type_basket IS RECORD (
--    basket bb_basketitem.idBasket%TYPE,
--    type bb_product.type%TYPE,
--    price bb_basketitem.price%TYPE,
--    qty bb_basketitem.quantity%TYPE);
--    
--  rec_basket type_basket;
--  lv_rate_num NUMBER(2,2);
--  lv_tax_num NUMBER(4,2) := 0;
--BEGIN
--  OPEN cur_basket;
--  
--  LOOP
--    FETCH cur_basket INTO rec_basket;
--      EXIT WHEN cur_basket%NOTFOUND;
--      
--      IF rec_basket.type = 'E' THEN lv_rate_num := .05; END IF;
--      IF rec_basket.type = 'C' THEN lv_rate_num := .03; END IF;
--      
--      lv_tax_num := lv_tax_num + ((rec_basket.price * rec_basket.qty) * lv_rate_num);
--  END LOOP;
--  
--  CLOSE cur_basket;
--  
--  DBMS_OUTPUT.PUT_LINE(lv_tax_num);
--END;




---- Cursor FOR LOOP Example.
--DECLARE
--  CURSOR cur_prod IS
--    SELECT type, price
--      FROM bb_product
--      WHERE active = 1
--    FOR UPDATE NOWAIT;
--    
--  lv_sale bb_product.saleprice%TYPE;
--BEGIN
--  FOR rec_prod IN cur_prod LOOP
--    IF rec_prod.type = 'C' THEN lv_sale := rec_prod.price * 0.9;
--    ELSIF rec_prod.type = 'E' THEN lv_sale := rec_prod.price * 0.95;
--    END IF;
--    
--    UPDATE bb_product
--      SET saleprice = lv_sale
--      WHERE CURRENT OF cur_prod;
--  END LOOP;
--END;





---- Cursor with Parameters.
--DECLARE
--  CURSOR cur_order(p_basket NUMBER) IS
--    SELECT idBasket, idProduct, price, quantity
--      FROM bb_basketitem
--      WHERE idBasket = p_basket;
--      
--  lv_bask1_num bb_basket.idbasket%TYPE := 6;
--  lv_bask2_num bb_basket.idbasket%TYPE := 10;
--BEGIN
--  FOR rec_order IN cur_order(lv_bask1_num) LOOP
--    DBMS_OUTPUT.PUT_LINE(rec_order.idBasket || ' - ' || rec_order.idProduct || ' - ' || rec_order.price);
--  END LOOP;
--  
--  FOR rec_order IN cur_order(lv_bask2_num) LOOP
--    DBMS_OUTPUT.PUT_LINE(rec_order.idBasket || ' - ' || rec_order.idProduct || ' - ' || rec_order.price);
--  END LOOP;  
--END;






---- Cursor with Parameters.
--DECLARE
--  CURSOR cur_order(p_basket NUMBER) IS
--    SELECT idBasket, idProduct, price, quantity
--      FROM bb_basketitem
--      WHERE idBasket = p_basket;
--      
--  lv_bask1_num bb_basket.idbasket%TYPE := 6;
--  lv_bask2_num bb_basket.idbasket%TYPE := 10;
--BEGIN
--  FOR rec_order IN cur_order(lv_bask1_num) LOOP
--    DBMS_OUTPUT.PUT_LINE(rec_order.idBasket || ' - ' || rec_order.idProduct || ' - ' || rec_order.price);
--  END LOOP;
--  
--  FOR rec_order IN cur_order(lv_bask2_num) LOOP
--    DBMS_OUTPUT.PUT_LINE(rec_order.idBasket || ' - ' || rec_order.idProduct || ' - ' || rec_order.price);
--  END LOOP;  
--END;  





---- Cursor Variable.
--DECLARE
--  cv_prod SYS_REFCURSOR;
--  rec_item bb_basketitem%ROWTYPE;
--  rec_status bb_basketstatus%ROWTYPE;
--  lv_input1_num NUMBER(2) := 2;
--  lv_input2_num NUMBER(2) := 3;
--BEGIN
--  IF lv_input1_num = 1 THEN
--    OPEN cv_prod FOR SELECT * FROM bb_basketitem
--      WHERE idBasket = lv_input2_num;
--    LOOP
--      FETCH cv_prod INTO rec_item;
--      EXIT WHEN cv_prod%NOTFOUND;
--      DBMS_OUTPUT.PUT_LINE(rec_item.idProduct);
--    END LOOP;
--  ELSIF lv_input1_num = 2 THEN
--    OPEN cv_prod FOR SELECT * FROM bb_basketstatus
--                        WHERE idBasket = lv_input2_num;
--      LOOP 
--        FETCH cv_prod INTO rec_status;
--        EXIT WHEN cv_prod%NOTFOUND;
--        DBMS_OUTPUT.PUT_LINE(rec_status.idStage || ' - ' || rec_status.dtstage);
--      END LOOP;
--  END IF;
--END;






---- Bulk-processing.
--DECLARE
--  CURSOR cur_item IS
--    SELECT *
--    FROM bb_basketitem;
--  
--  TYPE type_item IS TABLE OF cur_item%ROWTYPE
--    INDEX BY PLS_INTEGER;
--    
--  tbl_item type_item;
--BEGIN
--  OPEN cur_item;
--  LOOP
--    FETCH cur_item BULK COLLECT INTO tbl_item LIMIT 1000;
--    FOR i IN 1..tbl_item.COUNT LOOP
--      DBMS_OUTPUT.PUT_LINE(tbl_item(i).idBasketitem || ' - ' || tbl_item(i).idProduct);
--    END LOOP;
--    EXIT WHEN cur_item%NOTFOUND;
--  END LOOP;
--  CLOSE cur_item;
--END;





---- Bulk-processing (DML).
--DECLARE
--  TYPE emp_type IS TABLE OF NUMBER INDEX
--    BY BINARY_INTEGER;
--  emp_tbl emp_type;
--BEGIN
--  SELECT employee_ID
--    BULK COLLECT INTO emp_tbl
--    FROM employees
--      WHERE classtype = '100';
--  FORALL i IN emp_tbl.FIRST .. emp_tbl.LAST
--    UPDATE employees
--      SET raise = salary * 0.06
--        WHERE employee_ID = emp_tbl(i);
--    COMMIT;
--END;





--DECLARE
--  ex_basket_fk exception;
--  PRAGMA EXCEPTION_INIT(EX_BASKET_FK, -2292);
--BEGIN
--  DELETE FROM bb_basket
--    WHERE idBasket = 4;
--EXCEPTION
--  WHEN ex_basket_fk THEN
--    DBMS_OUTPUT.PUT_LINE('Items still in the basket!');
--END;





--DECLARE
--  ex_prod_update EXCEPTION;
--  
--BEGIN
--  UPDATE bb_product
--    SET description = 'Miill grinder with 5 grind settings!'
--      WHERE idProduct = 30;
--  IF SQL%NOTFOUND THEN
--    RAISE ex_prod_update;
--  END IF;
--  
--EXCEPTION
--  WHEN ex_prod_update THEN
--    DBMS_OUTPUT.PUT_LINE('Invalid product ID entered');
--END;





-- User-Defined Exception
DECLARE
  lv_ordqty_num NUMBER(2) := 20;
  lv_stock_num bb_product.stock%TYPE;
  ex_prod_stk EXCEPTION;
BEGIN
  SELECT stock
    INTO lv_stock_num
    FROM bb_product
      WHERE idProduct = 2;
    
  IF lv_ordqty_num > lv_stock_num THEN
    RAISE ex_prod_stk; -- RAISE is like the keyword "throw".
  END IF;
EXCEPTION -- This is like the keyword "catch".
  WHEN ex_prod_stk THEN
    DBMS_OUTPUT.PUT_LINE('Requested quantity beyond stock level');
    DBMS_OUTPUT.PUT_LINE('Req qty = ' || lv_ordqty_num || ' Stock qty = ' || lv_stock_num);
END;