--SET SERVEROUTPUT ON;
/*
DECLARE 
  v_test VARCHAR2(16);
BEGIN
  v_test := 'RebellionRider';
  DBMS_OUTPUT.PUT_LINE(v_test);
  
  v_test := 'Bren misses Kate';
  DBMS_OUTPUT.PUT_LINE(v_test);
END;
*/




/*
DECLARE
  lv_ord_date DATE;
  lv_last_txt VARCHAR2(25);
  lv_mynum NUMBER := 3;
  lv_shipflag_bln BOOLEAN;
  lv_bln_txt VARCHAR2(5);
BEGIN
  lv_ord_date := SYSDATE;
  lv_last_txt := 'Does Kate miss Bren too?';
  
  DBMS_OUTPUT.PUT_LINE(lv_ord_date);
  DBMS_OUTPUT.PUT_LINE(lv_last_txt);
  DBMS_OUTPUT.PUT_LINE(lv_mynum);
  
  lv_shipflag_bln := TRUE;
  IF lv_shipflag_bln THEN
    lv_bln_txt := 'OK';
  END IF;
  DBMS_OUTPUT.PUT_LINE(lv_bln_txt);
END;
*/




/*
DECLARE
  lv_my_string VARCHAR2(25) := 'Kate is waiting for you.';
  
  lv_amt_num NUMBER(3,2) := 3.09;
  lv_mynum NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE(lv_my_string);  
  DBMS_OUTPUT.PUT_LINE(lv_amt_num);
  DBMS_OUTPUT.PUT_LINE(lv_mynum);
END;
*/