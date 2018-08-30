--DECLARE
----  lv_idBasket bb_basket.idBasket%TYPE;
--  lv_created_date DATE;
--  lv_basket_num NUMBER(3);
--  lv_qty_num NUMBER(3);
--  lv_sub_num NUMBER(5,2);
--  lv_days_num NUMBER(3);
--  lv_shopper_num NUMBER(3) := 25;
--BEGIN
--  SELECT idBasket, dtcreated, quantity, subtotal
--    INTO lv_basket_num, lv_created_date, lv_qty_num, lv_sub_num
--    FROM bb_basket
--      WHERE idShopper = lv_shopper_num
--        AND orderplaced = 0;
--  
--  lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - lv_created_date;        
--        
--  DBMS_OUTPUT.PUT_LINE(lv_basket_num || ' * ' || lv_created_date || ' * ' || lv_qty_num || ' * ' || lv_sub_num || ' * ' || lv_days_num);
--END;


--DECLARE
--  lv_state_txt bb_basket.shipstate%TYPE;
--  lv_sub_num bb_basket.subtotal%TYPE;
--  lv_tax_num NUMBER(4,2) := 0;
--BEGIN
--  SELECT subtotal, shipstate
--    INTO lv_sub_num, lv_state_txt
--    FROM bb_basket
--      WHERE idbasket = 4;
--      
--  IF lv_state_txt = 'VA' THEN
--    lv_tax_num := lv_sub_num * .06;
--  ELSIF lv_state_txt = 'ME' THEN
--    lv_tax_num := lv_sub_num * .05;    
--  ELSIF lv_state_txt = 'NY' THEN
--    lv_tax_num := lv_sub_num * .07; 
--  ELSE
--    lv_tax_num := lv_sub_num * .04;
--  END IF;
--  
--  DBMS_OUTPUT.PUT_LINE('ST: ' || lv_state_txt || ' Sub: ' || lv_sub_num || ' Tax: ' || lv_tax_num);
--END;





--DECLARE
--  lv_first_txt bb_shopper.firstname%TYPE := 'Jeffrey';
--  lv_last_txt bb_shopper.lastname%TYPE := 'Brand';
--  lv_email_txt bb_shopper.email%TYPE := 'jbrand@site.com';
--BEGIN
--  INSERT INTO bb_shopper (idshopper, firstname, lastname, email)
--    VALUES (bb_shopper_seq.NEXTVAL, lv_first_txt, lv_last_txt, lv_email_txt);
--  COMMIT;  
--  DBMS_OUTPUT.PUT_LINE('Success bro!');
--EXCEPTION
--   WHEN NO_DATA_FOUND THEN
--   DBMS_OUTPUT.PUT_LINE('Yo bro, error man!');
--END;





--DECLARE
--  TYPE type_basket IS RECORD(
--    basket bb_basket.idBasket%TYPE,
--    created bb_basket.dtcreated%TYPE,
--    qty bb_basket.quantity%TYPE,
--    sub bb_basket.subtotal%TYPE);
--  
--  rec_basket type_basket;
--  lv_days_num NUMBER(3);
--  lv_shopper_num NUMBER(3) := 25;
--BEGIN
--  SELECT idBasket, dtcreated, quantity, subtotal
--    INTO rec_basket
--    FROM bb_basket
--      WHERE idShopper = lv_shopper_num
--        AND orderplaced = 0;
--      lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - rec_basket.created;
--
--  DBMS_OUTPUT.PUT_LINE(rec_basket.basket || '*' ||
--                       rec_basket.created || '*' ||
--                       rec_basket.qty || '*' ||
--                       rec_basket.sub || '*' ||
--                       lv_days_num);
--EXCEPTION
--   WHEN NO_DATA_FOUND THEN
--   DBMS_OUTPUT.PUT_LINE('Yo bro, error man!');
--END;






--DECLARE
--  rec_shopper bb_shopper%ROWTYPE;
--BEGIN
--  SELECT *
--    INTO rec_shopper
--      FROM bb_shopper
--        WHERE idshopper = 25;
--  DBMS_OUTPUT.PUT_LINE(rec_shopper.lastname);        
--  DBMS_OUTPUT.PUT_LINE(rec_shopper.address);
--  DBMS_OUTPUT.PUT_LINE(rec_shopper.email);
--EXCEPTION
--   WHEN NO_DATA_FOUND THEN
--   DBMS_OUTPUT.PUT_LINE('Yo bro, error man!');
--END;






--DECLARE
--  rec_shopper bb_shopper%ROWTYPE;
--BEGIN
--  rec_shopper.idshopper := bb_shopper_seq.NEXTVAL;
--  rec_shopper.firstname := 'Kobe';
--  rec_shopper.lastname := 'Bryant';
--  rec_shopper.country := 'Italy';
--  
--  INSERT INTO bb_shopper
--    VALUES rec_shopper;
--EXCEPTION
--   WHEN NO_DATA_FOUND THEN
--   DBMS_OUTPUT.PUT_LINE('Yo bro, error man!');
--END;





----Associative Array
--DECLARE
--  TYPE type_roast IS TABLE OF NUMBER
--  INDEX BY BINARY_INTEGER;
--  tbl_roast type_roast;
--  lv_tot_num NUMBER := 0;
--  lv_cnt_num NUMBER := 0;
--  lv_avg_num NUMBER;
--  lv_samp1_num NUMBER(5,2) := 6.22;
--  lv_samp2_num NUMBER(5,2) := 6.13;
--  lv_samp3_num NUMBER(5,2) := 6.27;
--  lv_samp4_num NUMBER(5,2) := 6.16;
--  lv_samp5_num NUMBER(5,2);
--BEGIN
--  tbl_roast(1) := lv_samp1_num;
--  tbl_roast(2) := lv_samp2_num;
--  tbl_roast(3) := lv_samp3_num;
--  tbl_roast(4) := lv_samp4_num;
--  tbl_roast(5) := lv_samp5_num;
--  
--  FOR i IN 1..tbl_roast.COUNT LOOP
--    IF tbl_roast(i) IS NOT NULL THEN
--      lv_tot_num := lv_tot_num + tbl_roast(i);
--      lv_cnt_num := lv_cnt_num + 1;
--    END IF;
--  END LOOP;
--  
--  lv_avg_num := lv_tot_num / lv_cnt_num;
--  DBMS_OUTPUT.PUT_LINE(lv_tot_num);  
--  DBMS_OUTPUT.PUT_LINE(lv_cnt_num);  
--  DBMS_OUTPUT.PUT_LINE(tbl_roast.COUNT);  
--  DBMS_OUTPUT.PUT_LINE(lv_avg_num);  
--END;





-- Table of Records
--DECLARE
--  TYPE type_basketitems IS TABLE OF bb_basketitem%ROWTYPE
--  INDEX BY BINARY_INTEGER;
--  
--  tbl_items type_basketitems;
--  lv_ind_num NUMBER(3) := 1;
--  lv_id_num bb_basketitem.idproduct%TYPE := 7;
--  lv_price_num bb_basketitem.price%TYPE := 10.80;
--  lv_qty_num bb_basketitem.quantity%TYPE := 2;
--  lv_opt1_num bb_basketitem.option1%TYPE := 2;
--  lv_opt2_num bb_basketitem.option2%TYPE := 3;
--BEGIN
--  tbl_items(lv_ind_num).idproduct := lv_id_num;
--  tbl_items(lv_ind_num).price := lv_price_num;
--  tbl_items(lv_ind_num).quantity := lv_qty_num;
--  tbl_items(lv_ind_num).option1 := lv_opt1_num;
--  tbl_items(lv_ind_num).option2 := lv_opt2_num;
--  
--  DBMS_OUTPUT.PUT_LINE(lv_ind_num);  
--  DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).idproduct);
--  DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).price);
--END;






-- Bulk Processing
DECLARE
  TYPE type_product IS TABLE OF bb_product%ROWTYPE
    INDEX BY PLS_INTEGER;
  tbl_prod type_product;
BEGIN
  SELECT * BULK COLLECT INTO tbl_prod
    FROM bb_product
    WHERE type = 'E';
    
  FOR i IN 1..tbl_prod.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(tbl_prod(i).productname);
  END LOOP;
END;