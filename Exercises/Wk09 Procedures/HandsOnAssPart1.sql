-- SET SERVEROUTPUT ON;

-- Assign5-2
-- 1of3
--CREATE OR REPLACE PROCEDURE PROD_ADD_SP 
--(
--  p_product_name IN bb_product.PRODUCTNAME%TYPE,
--  p_description IN bb_product.DESCRIPTION%TYPE,
--  p_image_filename IN bb_product.PRODUCTIMAGE%TYPE,
--  p_price IN bb_product.PRICE%TYPE,
--  p_active_status IN bb_product.ACTIVE%TYPE
--)
--AS
--BEGIN
--  INSERT INTO BB_PRODUCT (IDPRODUCT, PRODUCTNAME, DESCRIPTION, PRODUCTIMAGE, PRICE, ACTIVE)
--  VALUES (BB_PRODID_SEQ.NEXTVAL, p_product_name, p_description, p_image_filename, p_price, p_active_status);
--END PROD_ADD_SP;



-- Assign5-2
-- 2of3
--EXECUTE PROD_ADD_SP('Roasted Blend', Well-balanced mix of roasted beans, a medium body', roasted.jpg',9.50, 1);



-- Assign5-2
-- 3of3
--SELECT *
--  FROM BB_PRODUCT
--    WHERE PRODUCTNAME = Roasted Blend';
    
    
    
    
    
-- Assign5-3
-- 1of2
--CREATE OR REPLACE PROCEDURE TAX_COST_SP
--(
--  p_state IN BB_TAX.STATE%TYPE,
--  p_subtotal IN NUMBER,  
--  p_tax_amount OUT NUMBER 
--)
--AS
--  lv_taxrate BB_TAX.TAXRATE%TYPE;
--BEGIN  
--  SELECT TAXRATE
--    INTO lv_taxrate
--    FROM BB_TAX
--      WHERE STATE = p_state;
--  
--  p_tax_amount := p_subtotal * lv_taxrate;
--END TAX_COST_SP;




-- Assign5-3
-- 2of2
--DECLARE
--  lv_tax_amount BB_TAX.TAXRATE%TYPE;
--BEGIN
--  TAX_COST_SP('VA', 100, lv_tax_amount);
--
--  DBMS_OUTPUT.PUT_LINE('lv_tax_amount:  || lv_tax_amount);
--  
--  EXCEPTION
--    WHEN NO_DATA_FOUND THEN
--      DBMS_OUTPUT.PUT_LINE('No tax assessed.');
--END;




-- Assign5-4
-- 1of5
--CREATE OR REPLACE PROCEDURE BASKET_CONFIRM_SP
--(
--  p_basketId IN BB_BASKET.IDBASKET%TYPE,
--  p_subtotal IN BB_BASKET.SUBTOTAL%TYPE,
--  p_shipping IN BB_BASKET.SHIPPING%TYPE,
--  p_tax IN BB_BASKET.TAX%TYPE,
--  p_total IN BB_BASKET.TOTAL%TYPE
--)
--AS
--  const_orderplaced CONSTANT NUMBER := 1;
--BEGIN  
--  UPDATE BB_BASKET
--    SET ORDERPLACED = const_orderplaced,
--    SUBTOTAL = p_subtotal,
--    SHIPPING = p_shipping,
--    TAX = p_tax,
--    TOTAL = p_total
--      WHERE IDBASKET = p_basketId;        
--END BASKET_CONFIRM_SP;



-- Assign5-4
-- 2of5
--INSERT INTO BB_BASKET (IDBASKET, QUANTITY, IDSHOPPER, ORDERPLACED, SUBTOTAL, TOTAL, SHIPPING, TAX, DTCREATED, PROMO) 
--  VALUES (17, 2, 22, 0, 0, 0, 0, 0, 28-FEB-12', 0); 
--INSERT INTO BB_BASKETITEM (IDBASKETITEM, IDPRODUCT, PRICE, QUANTITY, IDBASKET, OPTION1, OPTION2) 
--  VALUES (44, 7, 10.8, 3, 17, 2, 3); 
--INSERT INTO BB_BASKETITEM (IDBASKETITEM, IDPRODUCT, PRICE, QUANTITY, IDBASKET, OPTION1, OPTION2) 
--  VALUES (45, 8, 10.8, 3, 17, 2, 3);



-- Assign5-4
-- 3of5
--COMMIT;



-- Assign5-4
-- 4of5
--EXECUTE BASKET_CONFIRM_SP(17, 64.80, 8.00, 1.94, 74.74);



-- Assign5-4
-- 5of5
--SELECT subtotal, shipping, tax, total, orderplaced 
--  FROM bb_basket 
--    WHERE idbasket = 17;





-- Assign5-5
-- 1of2
--CREATE OR REPLACE PROCEDURE STATUS_SHIP_SP
--(
--  p_basketId IN BB_BASKETSTATUS.IDBASKET%TYPE,
--  p_date_shipped IN BB_BASKETSTATUS.DTSTAGE%TYPE,
--  p_shipper IN BB_BASKETSTATUS.SHIPPER%TYPE,
--  p_tracking_num IN BB_BASKETSTATUS.SHIPPINGNUM%TYPE
--)
--AS
--  const_idstage_shipped CONSTANT NUMBER := 3;
--BEGIN         
--  INSERT INTO BB_BASKETSTATUS (IDSTATUS, IDBASKET, DTSTAGE, SHIPPER, SHIPPINGNUM)
--    VALUES (BB_STATUS_SEQ.NEXTVAL, p_basketId, p_date_shipped, p_shipper, p_tracking_num);
--END STATUS_SHIP_SP;



-- Assign5-5
-- 2of2
--EXECUTE STATUS_SHIP_SP(3, 20-FEB-12', UPS', ZW2384YXK4957');





-- Assign5-6
-- 1of2
--CREATE OR REPLACE PROCEDURE STATUS_SP
--(
--  p_idbasket IN BB_BASKETSTATUS.IDBASKET%TYPE,
--  p_order_status_info OUT VARCHAR2
--)
--AS
--  lv_idstage_num BB_BASKETSTATUS.IDSTAGE%TYPE;
--BEGIN         
--  SELECT IDSTAGE
--  INTO lv_idstage_num
--  FROM BB_BASKETSTATUS 
--    WHERE IDBASKET = p_idbasket
--    AND DTSTAGE = (SELECT MAX(DTSTAGE)
--                                FROM BB_BASKETSTATUS
--                                GROUP BY IDBASKET
--                                HAVING IDBASKET = p_idbasket);
--                                
--  CASE lv_idstage_num 
--    WHEN 1 THEN p_order_status_info := 'Submitted and received';
--    WHEN 2 THEN p_order_status_info := 'Confirmed, processed, sent to shippin';
--    WHEN 3 THEN p_order_status_info := 'Shipped';
--    WHEN 4 THEN p_order_status_info := 'Cancelled';
--    WHEN 5 THEN p_order_status_info := 'Back-ordered';
--    ELSE p_order_status_info := 'No status is available bro :(';
--  END CASE; 
--
--  EXCEPTION
--    WHEN NO_DATA_FOUND THEN
--      DBMS_OUTPUT.PUT_LINE('Exception: No Data Found.');
--END STATUS_SP;


-- Assign5-6
-- 2of2
--DECLARE
--  lv_order_status_info VARCHAR2(50);
--BEGIN
--  STATUS_SP(3, lv_order_status_info);
--  DBMS_OUTPUT.PUT_LINE(lv_order_status_info);
--END;





