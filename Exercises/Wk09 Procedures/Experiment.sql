--CREATE OR REPLACE
--PROCEDURE tc_test_sp2 IS
--  PRAGMA AUTONOMOUS_TRANSACTION;
--BEGIN
--  INSERT INTO bb_test1
--    VALUES (2);
--  COMMIT;
--END;




--DECLARE
--  lv_var VARCHAR2(50);
--BEGIN
--  lv_var := &var;
--DBMS_OUTPUT.PUT_LINE(TO_CHAR(lv_var));
--END;



--DECLARE
--  lv_taxrate BB_TAX.TAXRATE%TYPE;
--  p_state BB_TAX.STATE%TYPE := 'VA';
--BEGIN
--  SELECT TAXRATE
--    INTO lv_taxrate
--    FROM BB_TAX
--      WHERE STATE = p_state;
--END;                        

--SELECT TAXRATE
--  FROM BB_TAX
--    WHERE STATE IN ('VA', 'NC');


    
--SELECT IDBASKET, DTSTAGE, IDSTAGE
--  FROM BB_BASKETSTATUS 
--    WHERE IDBASKET = 4
--    AND DTSTAGE = (SELECT MAX(DTSTAGE)
--                                FROM BB_BASKETSTATUS
--                                GROUP BY IDBASKET
--                                HAVING IDBASKET = 4);





--SELECT *
--  FROM dd_pledge
--    WHERE EXISTS(SELECT *
--                    FROM dd_pledge
--                      WHERE iddonor = 308
--                      AND idstatus = 10
--                      AND paymonths != 0);





--create or replace PROCEDURE IS_ACTIVE_PLEDGE_SP
--(
--  p_idpledge dd_pledge.idpledge%TYPE,
--  p_is_id_active_pledge OUT BOOLEAN
--)
--AS
--  lv_idstatus_open dd_status.idstatus%TYPE := 10;
--BEGIN
--  UPDATE dd_pledge
--    SET idpledge = p_idpledge
--      WHERE idpledge = p_idpledge
--      AND idstatus = lv_idstatus_open
--      AND paymonths != 0;
--    
--  IF SQL%FOUND THEN 
--    p_is_id_active_pledge := TRUE;
--    DBMS_OUTPUT.PUT_LINE('p_is_id_active_pledge: TRUE');
--  ELSE
--    p_is_id_active_pledge := FALSE;
--    DBMS_OUTPUT.PUT_LINE('p_is_id_active_pledge: FALSE');
--  END IF;
--END IS_ACTIVE_PLEDGE_SP;




--DECLARE
--  lv_idpledge dd_pledge.idpledge%TYPE := 104;
--  lv_is_id_active_pledge BOOLEAN;
--BEGIN
--  IS_ACTIVE_PLEDGE_SP(lv_idpledge, lv_is_id_active_pledge);
--END;



--DECLARE
--  lv_is_id_active_pledge BOOLEAN;
--  lv_idpledge dd_pledge.idpledge%TYPE := 104;
--  lv_correct_payamt dd_pledge.pledgeamt%TYPE;
--  lv_posted_payamt dd_pledge.pledgeamt%TYPE := 25;
--  
--  ex_incorrect_payamt EXCEPTION;
--BEGIN
--  -- Check  first if the idpledge is valid by calling my helper procedure.
--  IS_ACTIVE_PLEDGE_SP(lv_idpledge, lv_is_id_active_pledge);
--  
--  SELECT (pledgeamt / paymonths)
--    INTO lv_correct_payamt
--    FROM dd_pledge
--     WHERE idpledge = lv_idpledge;
--    
--  IF lv_correct_payamt != lv_posted_payamt THEN 
--    RAISE ex_incorrect_payamt;
--  ELSE
--    DBMS_OUTPUT.PUT_LINE('Great! Correct payment amount - planned payment = ' || lv_correct_payamt);
--  END IF;
--  
--  EXCEPTION
--    WHEN ex_incorrect_payamt THEN
--      DBMS_OUTPUT.PUT_LINE('Error 20050: Incorrect payment amount - planned payment = ' || lv_correct_payamt);
--END;




-- Get the number of payments made with a particular idpledge.
--SELECT COUNT(*)
--  FROM dd_payment
--    HAVING idpledge = 104
--  GROUP BY idpledge;



--SELECT SUM(payamt)
--  FROM dd_payment
--    WHERE idpledge = 104;

SELECT (pledgeamt - 140)
  FROM dd_pledge
    WHERE idpledge = 104;  