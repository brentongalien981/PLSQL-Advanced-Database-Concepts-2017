SET SERVEROUTPUT ON

-- Assignment5-10
-- 1of2
CREATE OR REPLACE PROCEDURE DDPROJ_SP
(
  p_idproj IN dd_project.idproj%TYPE,
  p_dd_project_record OUT dd_project%ROWTYPE
)
AS
BEGIN         
  SELECT *
    INTO p_dd_project_record
    FROM dd_project
      WHERE idproj = p_idproj;
END DDPROJ_SP;



-- Assignment5-10
-- 2of2
DECLARE
  lv_idproj NUMBER := 500;
  lv_dd_project_record dd_project%ROWTYPE;
BEGIN         
  DDPROJ_SP(lv_idproj, lv_dd_project_record);
  DBMS_OUTPUT.PUT_LINE('lv_idproj: ' || lv_idproj || ' - ' ||
                       'lv_dd_project_record.projname: ' || lv_dd_project_record.projname || ' - ' ||
                       'lv_dd_project_record.projstartdate: ' || lv_dd_project_record.projstartdate || ' - ' ||
                       'lv_dd_project_record.projenddate: ' || lv_dd_project_record.projenddate || ' - ' ||
                       'lv_dd_project_record.projfundgoal: ' || lv_dd_project_record.projfundgoal || ' - ' ||
                       'lv_dd_project_record.projcoord: ' || lv_dd_project_record.projcoord);
END DDPROJ_SP;





-- Assignment5-11
-- 1of2
CREATE OR REPLACE PROCEDURE DDPAY_SP
(
  p_iddonor IN dd_pledge.iddonor%TYPE,
  p_donor_has_active_pledge OUT BOOLEAN
)
AS
  lv_idstatus_open dd_status.idstatus%TYPE := 10;
BEGIN
  UPDATE dd_pledge
    SET iddonor = p_iddonor
      WHERE iddonor = p_iddonor
      AND idstatus = lv_idstatus_open
      AND paymonths != 0;
    
  IF SQL%FOUND THEN 
    p_donor_has_active_pledge := TRUE;
    DBMS_OUTPUT.PUT_LINE('p_donor_has_active_pledge: TRUE');
  ELSE
    p_donor_has_active_pledge := FALSE;
    DBMS_OUTPUT.PUT_LINE('p_donor_has_active_pledge: FALSE');
  END IF;
END DDPAY_SP;





-- Assignment5-11
-- 2of2
DECLARE
  lv_iddonor dd_pledge.iddonor%TYPE := 388;
  lv_donor_has_active_pledge BOOLEAN;
BEGIN
  DDPAY_SP(lv_iddonor, lv_donor_has_active_pledge);
END;





-- Assignment5-12
-- 1of3: Helper Procedure
CREATE OR REPLACE PROCEDURE CHECK_PLEDGE_VALIDITY_SP
(
  p_idpledge IN dd_pledge.idpledge%TYPE,
  p_is_id_active_pledge OUT BOOLEAN
)
AS
  lv_idstatus_open dd_status.idstatus%TYPE := 10;
BEGIN
  UPDATE dd_pledge
    SET idpledge = p_idpledge
      WHERE idpledge = p_idpledge
      AND idstatus = lv_idstatus_open
      AND paymonths != 0;
    
  IF SQL%FOUND THEN 
    p_is_id_active_pledge := TRUE;
  ELSE
    p_is_id_active_pledge := FALSE;
  END IF;
END CHECK_PLEDGE_VALIDITY_SP;



-- Assignment5-12
-- 2of3
CREATE OR REPLACE PROCEDURE DDCKPAY_SP
(
  p_idpledge IN dd_payment.idpledge%TYPE,
  p_payamt IN dd_payment.payamt%TYPE
)
AS
  lv_is_id_active_pledge BOOLEAN;
  lv_correct_payamt dd_pledge.pledgeamt%TYPE;
  
  ex_incorrect_payamt EXCEPTION;
BEGIN
  CHECK_PLEDGE_VALIDITY_SP(p_idpledge, lv_is_id_active_pledge);
  
  -- If idpledge is valid...
  IF lv_is_id_active_pledge THEN
    -- ..calculate the correct monthly pledge amount.
    SELECT (pledgeamt / paymonths)
      INTO lv_correct_payamt
      FROM dd_pledge
         WHERE idpledge = p_idpledge;
      
    -- If there's a mismatch in payment amounts..
    IF lv_correct_payamt != p_payamt THEN 
      RAISE ex_incorrect_payamt;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Great! Correct payment amount - planned payment = ' || lv_correct_payamt);
    END IF;
    
  -- else idpledge is invalid!
  ELSE
    DBMS_OUTPUT.PUT_LINE('No payment information found.');
  END IF;


  
  EXCEPTION
    WHEN ex_incorrect_payamt THEN
      DBMS_OUTPUT.PUT_LINE('Error 20050: Incorrect payment amount - planned payment = ' || lv_correct_payamt);
END DDCKPAY_SP;



-- Assignment5-12
-- 3of3
BEGIN
  DDCKPAY_SP(104, 25);
  DDCKPAY_SP(104, 20);
  DDCKPAY_SP(199, 25);
END;





-- Assignment5-13
-- 1of2
CREATE OR REPLACE PROCEDURE DDCKBAL_SP
(
  p_idpledge IN dd_pledge.idpledge%TYPE,
  p_pledgeamt OUT dd_pledge.pledgeamt%TYPE,
  p_pay_total_made OUT dd_pledge.pledgeamt%TYPE,
  p_remaining_bal OUT dd_pledge.pledgeamt%TYPE
)
AS
BEGIN
  SELECT pledgeamt
    INTO p_pledgeamt
    FROM dd_pledge
      WHERE idpledge = p_idpledge;

  SELECT SUM(payamt)
    INTO p_pay_total_made
    FROM dd_payment
      WHERE idpledge = p_idpledge;
      
  p_remaining_bal := p_pledgeamt - p_pay_total_made;
END DDCKBAL_SP;



-- Assignment5-13
-- 2of2
DECLARE
  lv_idpledge dd_pledge.idpledge%TYPE := 105;
  lv_pledgeamt dd_pledge.pledgeamt%TYPE;
  lv_pay_total_made dd_pledge.pledgeamt%TYPE;
  lv_remaining_bal dd_pledge.pledgeamt%TYPE;
BEGIN
  DDCKBAL_SP(lv_idpledge, lv_pledgeamt, lv_pay_total_made, lv_remaining_bal);
      
  DBMS_OUTPUT.PUT_LINE('lv_pledgeamt: ' || lv_pledgeamt); 
  DBMS_OUTPUT.PUT_LINE('lv_pay_total_made: ' || lv_pay_total_made); 
  DBMS_OUTPUT.PUT_LINE('lv_remaining_bal: ' || lv_remaining_bal); 
END;