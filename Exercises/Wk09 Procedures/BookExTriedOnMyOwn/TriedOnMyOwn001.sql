--CREATE OR REPLACE
--PROCEDURE SHIP_COST_SP
--(
--  p_qty IN NUMBER,
--  p_ship OUT NUMBER
--)
--AS
--BEGIN
--  IF p_qty > 10 THEN
--    p_ship := 11.00;
--  ELSIF p_qty > 5 THEN
--    p_ship := 8.00;
--  ELSE
--    p_ship := 5.00;
--  END IF;
--END SHIP_COST_SP;





--DECLARE
--  lv_ship_num NUMBER(6,2);
--BEGIN
--  SHIP_COST_SP(7, lv_ship_num);
--  DBMS_OUTPUT.PUT_LINE('Ship Cost = ' || lv_ship_num || ' yeaH!');
--END;





--DECLARE 
--  lv_ship_num NUMBER(6,2);
--BEGIN
--  SHIP_COST_SP(p_ship => lv_ship_num, 
--               p_qty => 7);
--  DBMS_OUTPUT.PUT_LINE('Ship Cost = ' || lv_ship_num);
--END;





--BEGIN
--  FOR rec_purch IN cur_purch LOOP
--    IF rec_purch.sub > 50 THEN
--      promo_flag := 'A';
--    ELSIF rec_purch.sub > 25 THEN
--      promo_flag := 'B';
--    END IF;
--      DBMS_OUTPUT.PUT_LINE(rec_purch.idshopper || ' has sub ' ||
--                           rec_purch.sub || ' and flag = ' ||
--                           promo_flag);
--    IF promo_flag IS NOT NULL THEN
--      DBMS_OUTPUT.PUT_LINE('Insert processed for shopper ' || rec_purch.idshopper);
--      INSERT INTO bb_promolist
--        VALUES (rec_purch.idshopper, p_nth, p_year, promo_flag, NULL);
--    END IF;
--    
--    promo_flag := '';
--  END LOOP;
--  
--  COMMIT;
--END;





